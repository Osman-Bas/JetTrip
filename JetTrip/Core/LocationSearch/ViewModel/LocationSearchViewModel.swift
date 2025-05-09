//
//  LocationSearchViewModel.swift
//  JetTrip
//
//  Created by Osman Baş on 28.04.2025.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    // Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickupTime:String?
    @Published var dropOffTime:String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    //Lifecycle
        override init() {
            super.init()
            
            searchCompleter.delegate = self
            searchCompleter.queryFragment = queryFragment
        }
    //Helpers
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("Debug:Locarion search error: \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
            print("debug:location coordinate: \(coordinate)")
             }
    } //üstteki parantez kapanmamış.
    
    func locationSearch(forLocalSearchCompletion localSearh: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearh.title.appending(localSearh.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
        
        }
    func computeRidePrice(forType type: RideType)->Double {
        guard let destCoordinate = selectedUberLocation?.coordinate else { return 0.0}
        guard let userCoordinate = self.userLocation else { return 0.0}
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
    }
    
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D,
                             to destination: CLLocationCoordinate2D,
                             completion: @escaping(MKRoute) -> Void){
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destPlacemark)
        let directions = MKDirections(request: request)
        directions.calculate{ response, error in
            if let error = error {
                print("Error calculating directions : \(error.localizedDescription)")
                return
            }
            guard let route = response?.routes.first else {return}
            self.configurePickupAndDropoffTimes(with: route.expectedTravelTime)
            completion(route)
            
        }
        
    }
    
    func configurePickupAndDropoffTimes(with expectedTravelTime: Double) {
        let formaetter = DateFormatter()
        formaetter.dateFormat = "h:mm a"
        
        pickupTime = formaetter.string(from: Date())
        dropOffTime = formaetter.string(from: Date() + expectedTravelTime)
    }
    
    }
        
    // MKLocalSearchComplaterDelegate
    extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
        func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            self.results = completer.results
        }
    }
    
    


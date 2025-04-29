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
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
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
            self.selectedLocationCoordinate = coordinate
            print("debug:location coordinate: \(coordinate)")
             }
    } //üstteki parantez kapanmamış.
    
    func locationSearch(forLocalSearchCompletion localSearh: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearh.title.appending(localSearh.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
        
    }
    
    }
        
    // MKLocalSearchComplaterDelegate
    extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
        func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            self.results = completer.results
        }
    }
    
    


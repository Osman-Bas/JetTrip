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
    @Published var selectedLocation: String?
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
    
    func selectLocation(_ location: String) {
        self.selectedLocation = location
        print("Debug: Selected location: \(self.selectedLocation)")
    }
    
    }
        
    // MKLocalSearchComplaterDelegate
    extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
        func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            self.results = completer.results
        }
    }
    
    


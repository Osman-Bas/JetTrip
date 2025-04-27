//
//  LocationManager.swift
//  JetTrip
//
//  Created by Osman Baş on 27.04.2025.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    
    override init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

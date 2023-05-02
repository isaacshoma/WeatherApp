//
//  LocationManager.swift
//  Weather
//
//  Created by Isaac Shoma
// 615391
import Foundation
import CoreLocation

// Manages loction service
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // local manager instance
    let manager = CLLocationManager()
    // The current location of the device
    @Published var location: CLLocationCoordinate2D?
    // A boolean flag indicating if the location is currently being fetched
    @Published var isLoading = false
    // Initialize the location manager
    override init() {
        super.init()
        manager.delegate = self
    }
    
    // Request the current location
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    // Called when the location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    // Called when there is an error getting the location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
}

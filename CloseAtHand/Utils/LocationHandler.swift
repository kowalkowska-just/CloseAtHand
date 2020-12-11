//
//  LocationHandler.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import CoreLocation

protocol LocationHandlerDelegate {
    func requestWeatherForLocation(location: CLLocation)
}

class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHandler()
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var delegate : LocationHandlerDelegate?
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        setupLocation()
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestLocation()
        }
    }
    
    func requestLocation() {
        guard let currentLocation = currentLocation else { return }
        
        print("DEBUG: Current location is \(currentLocation)")
        delegate?.requestWeatherForLocation(location: currentLocation)
    }

}

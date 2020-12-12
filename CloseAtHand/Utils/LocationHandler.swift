//
//  LocationHandler.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHandler()
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    
    override init() {
        super.init()
    
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            print("DEBUG: Failed - Location service disabled.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        locationManager.stopUpdatingLocation()
        requestWeatherForLocation()
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else { return }
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        
        WeatherManager.shered.fetchWeather(longitude: long, latitude: lat)
    }

}

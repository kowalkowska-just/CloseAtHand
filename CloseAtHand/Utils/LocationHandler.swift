//
//  LocationHandler.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 16/12/2020.
//

import UIKit
import CoreLocation

protocol LocationUpdateProtocol {
    func locationDidUpdateToLocation(location: CLLocation)
}

public class LocationHandler: NSObject, CLLocationManagerDelegate {

    static let shared = LocationHandler()
    
    var location = CLLocation()
    var locationManager: CLLocationManager!
    var delegate: LocationUpdateProtocol!

 //   var weatherManager = WeatherManager()
    
    override init () {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if manager.location != nil {
            guard let location = locations.last else { return }
            locationManager.stopUpdatingLocation()
            delegate.locationDidUpdateToLocation(location: location)
        } 
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUG: Failed update location with error: \(error)")
    }
}

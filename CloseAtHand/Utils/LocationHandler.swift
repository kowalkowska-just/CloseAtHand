//
//  LocationHandler.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 16/12/2020.
//

import UIKit
import CoreLocation

//protocol LocationUpdateProtocol {
//    func locationDidUpdateToLocation(location: CLLocation)
//}

typealias LocateMeCallback = (_ location: CLLocation?) -> Void

class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHandler()
    
    var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.activityType = .automotiveNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        
        return locationManager
    }()
    
    var locateMeCallback: LocateMeCallback?
    var currentLocation: CLLocation?
    var isCurrentLocationAvailable: Bool {
        return currentLocation != nil
    }
    
    var location = CLLocation()
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager.delegate = self
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // Disable location features
            print("DEBUG: Fail permission to get current location of user")
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            // Enable basic location features
            enableMyWhenInUseFeatures()
        @unknown default:
            break
        }
    }
        
    func enableMyWhenInUseFeatures() {
       locationManager.startUpdatingLocation()
    }

    func locateMe(callback: @escaping LocateMeCallback) {
        self.locateMeCallback = callback
        locationManagerDidChangeAuthorization(locationManager)
    }

    private override init() {}

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print("DEBUG: Locations = \(location.coordinate.latitude) \(location.coordinate.longitude)")
        locateMeCallback?(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationManagerDidChangeAuthorization(self.locationManager)
    }
}

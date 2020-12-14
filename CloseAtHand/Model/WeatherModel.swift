//
//  WeatherModel.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import Foundation
import CoreData

struct WeatherModel {
    
    let latitude: Double
    let longitude: Double
    
    //Current Weather
    let date: Int
    let sunrise: Int
    let sunset: Int
    let temperature: Double
    let feelsLikeTemperature: Double
    let pressure: Int
    let humidity: Int
    let uvi: Float
    let clouds: Int
    let visibility: Int
    let windSpeed: Float
    let weatherId: Int
    let weatherDescription: String
    let weatherIcon: String
    
//    Country and city name
    var location: [String] {
        let geoCoder = CLGeocoder()
        var addressArray = [String]()
        let location = CLLocation(latitude: latitude, longitude: longitude)

        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if error != nil {
                print("DEBUG: Failed get address from lat and long with error:\(error)")
                return
            } else if let country = placemarks?.first?.country, let city = placemarks?.first?.locality {
                addressArray.append(country)
                addressArray.append(city)
                print("DEBUG: LOCALITY is \(addressArray)")
            }
//            let pm = placemarks! as [CLPlacemark]
//
//            if pm.count > 0 {
//                let pm = placemarks![0]
//                if addressArray.isEmpty {
//                    guard let country = pm.country else { return }
//                    addressArray.append(country)
//
//                    guard let locality = pm.locality else { return }
//                    addressArray.append(locality)
//                    print("DEBUG: LOCALITY is \(addressArray)")
//                }
//            }
        })
        return addressArray
    }
}

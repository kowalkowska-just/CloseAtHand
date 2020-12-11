//
//  WeatherManager.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import Foundation
import CoreLocation


struct WeatherManager: LocationHandlerDelegate {
    func requestWeatherForLocation(location: CLLocation) {
        let long = location.coordinate.longitude
        let lat = location.coordinate.latitude
        
        var weatherURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=minutely,alerts&appid=\(Key.keyWeather)&units=metric"
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                guard let data = data, error == nil else {
                    print("DEBUG: Failed perform request with error: \(error)")
                    return
                }
                
                
                
            }
        }
    }
}

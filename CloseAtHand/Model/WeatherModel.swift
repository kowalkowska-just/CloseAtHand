//
//  WeatherModel.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import Foundation

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
    
    var temperatureString: String {
        return String(format: "%.0f", temperature) + "°"
    }
    
    var windSpeedString: String {
        return String(format: "%.1f", windSpeed) + " m/s"
    }
    
    var description: String {
        return weatherDescription.prefix(1).uppercased() + weatherDescription.lowercased().dropFirst()
    }
    
    var conditionImage: String {
        switch weatherId {
        case 200, 201, 202:
            return "thunderstorm-with-rain"
        case 210, 211:
            return "thunderstorm"
        case 212, 221:
            return "heavy-tunderstorm"
        case 230, 231, 232:
            return "thunderstorm-with-drizzle"
        case 300, 301, 302, 310, 311:
            return "drizzle"
        case 312, 313, 314, 321:
            return "shower-drizzle"
        case 500, 501:
            return "moderate-rain"
        case 502, 503, 504:
            return "heavy-rain"
        case 520, 521, 522, 531:
            return "shower-rain"
        case 511:
            return "freezing-rain"
        case 600, 601:
            return "light-snow"
        case 602, 621:
            return "heavy-snow"
        case 611, 612, 613, 615, 616, 620, 622:
            return "rain-and-snow"
        case 701, 711, 721, 741:
            return "fog"
        case 731, 751, 761:
            return "sand"
        case 762:
            return "volcanic-ash"
        case 771, 781:
            return "tornado"
        case 800:
            if weatherIcon.range(of: "n") != nil {
                return "clear-sky-night"
            } else {
                return "clear-sky-day"
            }
        case 801:
            if weatherIcon.range(of: "n") != nil {
                return "few-clouds-night"
            } else {
                return "few-clouds-day"
            }
        case 802, 803, 804:
            return "scattered-clouds"
        default:
            return "scattered-clouds"
        }
    }
}

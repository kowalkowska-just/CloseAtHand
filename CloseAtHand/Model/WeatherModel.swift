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
}

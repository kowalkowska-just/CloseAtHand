//
//  CurrentWeatherModel.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import Foundation

struct CurrentWeatherModel: Codable {
    let dt: Int //UTC
    let sunrise: Int //UTC
    let sunset: Int //UTC
    let temp: Double //C
    let feels_like: Double //C
    let pressure: Int //hPa
    let humidity: Int //%
    let uvi: Float
    let clouds: Int //%
    let visibility: Int //m
    let wind_speed: Float //m/s
    let weather: [CurrentWeather]
}

struct CurrentWeather: Codable {
    let id: Int
    let description: String
    let icon: String
}

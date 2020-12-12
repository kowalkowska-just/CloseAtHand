//
//  WeatherData.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import Foundation

struct WeatherData: Codable {
    let lat: Double
    let lon: Double
    let timezone_offset: Int
    let current : CurrentWeatherData
    let hourly: [HourlyForecastData]
    let daily: [DailyForecastData]
}

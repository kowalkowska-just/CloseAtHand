//
//  CurrentWeather.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import Foundation

struct WeatherModel: Codable {
    let lat: Double
    let lon: Double
    let timezone_offset: Int
    let current : CurrentWeatherModel
    let hourly: [HourlyForecastModel]
    let daily: [DailyForecastModel]
}

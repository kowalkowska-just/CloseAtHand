//
//  WeekForecastModel.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import Foundation


struct DailyForecastModel: Codable {
    let dt: Int //UTC
    let temp: Temperature //C
    let pop: Double
    let weather: [DailyForecastWeather]
}

struct Temperature: Codable {
    let day: Double //C
    let night: Double //C
}

struct DailyForecastWeather: Codable {
    let id: Int
    let description: String
    let icon: String
}

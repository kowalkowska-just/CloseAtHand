//
//  HourlyForecastModel.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import Foundation


struct HourlyForecastModel: Codable {
    let dt: Int //UTC
    let temp: Double //C
    let pop: Double
    let weather: [HourlyForecastWeather]
}

struct HourlyForecastWeather: Codable {
    let id: Int
    let description: String
    let icon: String
}

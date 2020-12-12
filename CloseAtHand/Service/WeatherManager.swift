//
//  WeatherManager.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}

struct WeatherManager {
    
    static let shered = WeatherManager()
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(longitude: Double, latitude: Double) {
        let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely,alerts&appid=\(Key.keyWeather)&units=metric"
        
        performRequest(with: weatherURL)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                guard let weatherData = data, error == nil else {
                    print("DEBUG: Failed perform request with error: \(error)")
                    return
                }
                if let weather = self.parseJSON(weatherData) {
                    self.delegate?.didUpdateWeather(self, weather: weather)
                }
            }.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) ->  WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let json = try decoder.decode(WeatherData.self, from: weatherData)
            let latitude = json.lat
            let longitude = json.lon
            let currentWeather = json.current
            let date = currentWeather.dt
            let sunrise = currentWeather.sunrise
            let sunset = currentWeather.sunset
            let temperature = currentWeather.temp
            let feelsLikeTemperature = currentWeather.feels_like
            let pressure = currentWeather.pressure
            let humidity = currentWeather.humidity
            let uvi = currentWeather.uvi
            let clouds = currentWeather.clouds
            let visibility = currentWeather.visibility
            let windSpeed = currentWeather.wind_speed
            let weatherId = currentWeather.weather[0].id
            let weatherDescription = currentWeather.weather[0].description
            let weatherIcon = currentWeather.weather[0].icon
            
            let weather = WeatherModel(latitude: latitude, longitude: longitude, date: date, sunrise: sunrise, sunset: sunset, temperature: temperature, feelsLikeTemperature: feelsLikeTemperature, pressure: pressure, humidity: humidity, uvi: uvi, clouds: clouds, visibility: visibility, windSpeed: windSpeed, weatherId: weatherId, weatherDescription: weatherDescription, weatherIcon: weatherIcon)
            
            return weather
        } catch {
            print("DEBUG: Failed parse JSON with error: \(error)")
            return nil
        }
    }
}

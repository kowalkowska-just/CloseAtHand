//
//  WeatherManager.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 11/12/2020.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
   // static let shered = WeatherManager()
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(longitude: Double, latitude: Double) {
        let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely,alerts&appid=\(Key.keyWeather)&units=metric"
        
        performRequest(with: weatherURL)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let weatherData = data {
                    if let weatherModel = parseJSON(weatherData) {
                        print("DEBUG: Weather model: \(weatherModel)")
                        
                        self.delegate?.didUpdateWeather(weather: weatherModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) ->  WeatherModel? {
        var json: WeatherData?
        let decoder = JSONDecoder()
        do {
            json = try decoder.decode(WeatherData.self, from: weatherData)
            
            guard let result = json else { return nil }
            
            let latitude = result.lat
            let longitude = result.lon
            let currentWeather = result.current
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
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

//
//  WeatherManager.swift
//  Clima
//
//  Created by Megan Ma on 2022-05-17.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel)
    func didFailWithError(_ weatherManager: WeatherManager, error: Error)
}


struct WeatherManager {
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=b58291b9e6bbfb0ef13d2eb431c74a72&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(self, error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        delegate?.didUpdateWeather(self, weatherModel: weather)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let cityName = decodedData.name
            let weatherId = decodedData.weather[0].id
            let temp = decodedData.main.temp
            
            return WeatherModel(conditionId: weatherId, cityName: cityName, temperature: temp)
            
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
    
}




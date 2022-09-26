//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by MacMini on 25.09.22.
//

import Foundation

class NetworkWeatheManager {
    var completionHandler: ((WeatherModel) -> Void)?
    func fetchWeatherRequest(forCity city: String) {
        let stringURL = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: stringURL) else { return print("No url") }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, responser, error in
            if let data = data {
                if let weatherModel = self?.parseJSON(withData: data) {
                    self?.completionHandler?(weatherModel)
                }
            }
        })
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(WeatherData.self, from: data)
            return WeatherModel(weatherData: model)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

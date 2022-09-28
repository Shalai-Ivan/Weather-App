//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by MacMini on 25.09.22.
//

import Foundation

final class NetworkWeatheManager {
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
    
    private func parseJSON(withData data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(WeatherData.self, from: data)
            return WeatherModel(weatherData: model)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return nil
    }
}

//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by MacMini on 25.09.22.
//

import Foundation
import CoreLocation

enum TypeRequest {
    case city(forCity: String)
    case location(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

final class NetworkWeatheManager {
    var completionHandler: ((WeatherModel) -> Void)?
    func fetchWeatherRequest(forRequest request: TypeRequest) {
        var stringURL = ""
        switch request {
        case .city(let city):
            stringURL = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .location(let latitude, let longitude):
            stringURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        performFetchRequest(forURL: stringURL)
    }
    private func performFetchRequest(forURL stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
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

//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by MacMini on 25.09.22.
//

import Foundation

struct NetworkWeatheManager {
    func fetchWeatherRequest(forCity city: String) {
        let stringURL = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        guard let url = URL(string: stringURL) else { return print("No url") }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url, completionHandler: { data, responser, error in
            if let data = data {
                let dataTask = String(data: data, encoding: .utf8)
                print("Data - \(dataTask!)")
            } else {
                print("Unlucky")
            }
        })
        task.resume()
    }
}

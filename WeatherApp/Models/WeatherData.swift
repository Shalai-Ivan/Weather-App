//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by MacMini on 26.09.22.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Main: Codable {
    let tmpr: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case tmpr = "temp"
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}

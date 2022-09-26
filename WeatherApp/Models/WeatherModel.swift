//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by MacMini on 26.09.22.
//

import Foundation
import UIKit

struct WeatherModel {
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    let temperatureFeelsLike: Double
    var temperatureFeelsLikeString: String {
        return String(format: "%.0f", temperatureFeelsLike)
    }
    let conditionCode: Int
    var systemCloudIcon: String {
        switch conditionCode {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "smoke.fill"
        case 801...804:
            return "cloud.fill"
        case 800:
            return "sun.min.fill"
        default:
            return "nosign"
        }
    }
    init?(weatherData: WeatherData) {
        cityName = weatherData.name
        temperature = weatherData.main.tmpr
        temperatureFeelsLike = weatherData.main.feelsLike
        conditionCode = weatherData.weather.first!.id
    }
}

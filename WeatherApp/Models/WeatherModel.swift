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
    let pressure: Int
    let humidity: Int
    let weatherDescription: String
    let windSpeed: Double
    let sunrise: Double
    var sunriseString: String {
        sunRiseSetCoder(time: sunrise)
    }
    let sunset: Double
    var sunsetString: String {
        sunRiseSetCoder(time: sunset)
    }
    let timezone: Int
    var timezoneCoder: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        let abreviation = dateFormatter.timeZone.abbreviation() ?? ""
        return abreviation
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
            return "weather"
        }
    }
    init?(weatherData: WeatherData) {
        cityName = weatherData.name
        temperature = weatherData.main.tmpr
        temperatureFeelsLike = weatherData.main.feelsLike
        conditionCode = weatherData.weather.first!.id
        pressure = weatherData.main.pressure
        humidity = weatherData.main.humidity
        weatherDescription = weatherData.weather.first!.description
        windSpeed = weatherData.wind.speed
        sunrise = weatherData.sys.sunrise
        sunset = weatherData.sys.sunset
        timezone = weatherData.timezone
    }
    private func sunRiseSetCoder(time: Double) -> String {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: time)
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

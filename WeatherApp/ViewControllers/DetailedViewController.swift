//
//  DetailedViewController.swift
//  WeatherApp
//
//  Created by MacMini on 26.09.22.
//

import UIKit

final class DetailedViewController: UIViewController {
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var timezoneLabel: UILabel!
    @IBOutlet private weak var sunriseLabel: UILabel!
    @IBOutlet private weak var sunsetLabel: UILabel!
    var image = UIImage()
    var weatherModel: WeatherModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateWeather(weatherModel: weatherModel)
    }
    private func updateWeather(weatherModel: WeatherModel?) {
        guard let weatherModel = weatherModel else { return }
        cityNameLabel.text = weatherModel.cityName
        temperatureLabel.text = "\(weatherModel.temperatureString)°C"
        feelsLikeLabel.text = "\(weatherModel.temperatureFeelsLikeString)°C"
        pressureLabel.text = "\(weatherModel.pressure)hPa"
        humidityLabel.text = "\(weatherModel.humidity)%"
        weatherLabel.text = weatherModel.weatherDescription
        windSpeedLabel.text = "\(weatherModel.windSpeed)m/s"
        timezoneLabel.text = weatherModel.timezoneCoder
        sunriseLabel.text = weatherModel.sunriseString
        sunsetLabel.text = weatherModel.sunsetString
        backgroundImage.image = image
    }
}

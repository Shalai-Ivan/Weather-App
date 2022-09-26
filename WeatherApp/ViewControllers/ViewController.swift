//
//  ViewController.swift
//  WeatherApp
//
//  Created by MacMini on 24.09.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cloudsImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTmprLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    let networkWeatherManager = NetworkWeatheManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkWeatherManager.completionHandler = { [weak self] weatherModel in
            self?.updateWeather(weatherModel: weatherModel)
        }
        networkWeatherManager.fetchWeatherRequest(forCity: "Minsk")
    }
    @IBAction func tapSearchImage(_ sender: Any) {
        createAlert { [weak self] city in
            self?.networkWeatherManager.fetchWeatherRequest(forCity: city)
        }
    }
    func updateWeather(weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherModel.temperatureString
            self.feelsLikeTmprLabel.text = weatherModel.temperatureFeelsLikeString
            self.cityLabel.text = weatherModel.cityName
            self.cloudsImage.image = UIImage(systemName: weatherModel.systemCloudIcon)
            self.backgroundImage.image = UIImage(named: weatherModel.systemCloudIcon)
        }
    }
}

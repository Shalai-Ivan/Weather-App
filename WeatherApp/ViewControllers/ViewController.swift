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
    }
    @IBAction func tapSearchImage(_ sender: Any) {
        networkWeatherManager.fetchWeatherRequest(forCity: "Minsk")
    }
}


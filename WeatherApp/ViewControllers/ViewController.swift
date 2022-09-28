//
//  ViewController.swift
//  WeatherApp
//
//  Created by MacMini on 24.09.22.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var cloudsImage: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeTmprLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    private let networkWeatherManager = NetworkWeatheManager()
    private var weatherModel: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkWeatherManager.completionHandler = { [weak self] weatherModel in
            self?.weatherModel = weatherModel
            self?.updateWeather(weatherModel: weatherModel)
        }
        animateBackgroundImage()
    }
    private func updateWeather(weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherModel.temperatureString
            self.feelsLikeTmprLabel.text = weatherModel.temperatureFeelsLikeString
            self.cityLabel.text = weatherModel.cityName
            self.cloudsImage.image = UIImage(systemName: weatherModel.systemCloudIcon)
            self.backgroundImage.image = UIImage(named: weatherModel.systemCloudIcon)
            self.backgroundImage.alpha = 0.8
        }
    }
    private func popoverPresenting() {
        let storyboard = UIStoryboard(name: "Detailed", bundle: nil)
        guard let detailedVC = storyboard.instantiateInitialViewController() as? DetailedViewController else { return }
        detailedVC.modalPresentationStyle = .popover
        detailedVC.preferredContentSize = CGSize(width: view.frame.width * 0.8, height: view.frame.height * 0.8)
        let popoverVC = detailedVC.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = view
        popoverVC?.sourceRect = CGRect(x: view.frame.midX, y: view.frame.midY, width: 0, height: 0 )
        popoverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        detailedVC.image = self.backgroundImage.image!
        detailedVC.weatherModel = weatherModel
        present(detailedVC, animated: true)
    }
    private func animateBackgroundImage() {
        UIView.animate(withDuration: 10, delay: 0, options: [.repeat, .autoreverse]) { [weak self] in
            self?.backgroundImage.frame.origin.x += 100
        }
    }
    @IBAction private func tapSearchImage(_ sender: Any) {
        createAlert { [weak self] city in
            self?.networkWeatherManager.fetchWeatherRequest(forCity: city)
        }
    }
    @IBAction private func tapDetailedInformation(_ sender: Any) {
        popoverPresenting()
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

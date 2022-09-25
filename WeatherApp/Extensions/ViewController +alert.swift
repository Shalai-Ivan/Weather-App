//
//  SearchWeatherAlert.swift
//  WeatherApp
//
//  Created by MacMini on 25.09.22.
//

import UIKit

extension ViewController {
    func createAlert(actionHandler: @escaping ((String) -> Void)) {
        let alert = UIAlertController(title: "Поиск", message: "Введите город", preferredStyle: .alert)
        alert.addTextField()
        let searchAction = UIAlertAction(title: "Найти", style: .default) { action in
            guard let text = alert.textFields?.first?.text else { return }
            if text != "" {
                let cityName = text.split(separator: " ").joined(separator: "%20")
                actionHandler(cityName)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(searchAction)
        present(alert, animated: true)
    }
}

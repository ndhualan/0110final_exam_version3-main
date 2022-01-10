//
//  ViewController.swift
//  WeatherForecast
//
//  Created by 羅壽之 on 2020/12/3.
//

import UIKit
import CoreData

class WeatherViewController: UIViewController {
    
    @IBOutlet var cityName: UILabel!
    @IBOutlet var weatherState: UILabel!
    @IBOutlet var weatherTemp: UILabel!
    @IBOutlet var weatherHumi: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    
    private let API_URL = "https://api.openweathermap.org/data/2.5/weather?"
    private let ICON_URL = "https://openweathermap.org/img/wn/"
    private let API_KEY = "3832f25ca787be07a1587887384398af"

    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getForecast(location: restaurant.city)
    }
    
    func getForecast(location: String) {
        
        guard let accessURL = URL(string: API_URL + "q=\(location)&units=metric&lang=zh_tw&appid=\(API_KEY)") else {
            return
        }
        
        let request = URLRequest(url: accessURL)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            //parse data
            if let data = data {
                let decoder = JSONDecoder()
                if let weatherData = try? decoder.decode(WeatherForecastData.self, from: data) {
                    self.getImage(weatherCode: weatherData.weather[0].icon)
                    OperationQueue.main.addOperation {
                        self.cityName.text = weatherData.name
                        self.weatherState.text = weatherData.weather[0].description
                        self.weatherTemp.text = "Temperature " +  String(weatherData.main.temp) + "°C"
                        self.weatherHumi.text = "Humidity " + String(weatherData.main.humidity) + "%"
                    }
                }
            }
        })
        
        task.resume()
    }

    func getImage(weatherCode: String) {
        
        guard let accessURL = URL(string: ICON_URL + "\(weatherCode)@2x.png") else {
            return
        }
        
        let request = URLRequest(url: accessURL)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            //parse data
            if let data = data, let image = UIImage(data: data) {
                OperationQueue.main.addOperation {
                    self.weatherIcon.image = image
                }
            }
        })
        
        task.resume()
    }
  
}


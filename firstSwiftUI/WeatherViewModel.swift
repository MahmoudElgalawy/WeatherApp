//
//  WeatherViewModel.swift
//  firstSwiftUI
//
//  Created by Mahmoud  on 24/08/2024.
//



import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?

    private let apiKey = "08d0035332994f3ba3a223201242308"
    private let urlString = "https://api.weatherapi.com/v1/forecast.json"

    func fetchWeather() {
        guard let url = URL(string: "\(urlString)?key=\(apiKey)&q=30.0444,31.2357&days=3&aqi=yes&alerts=no") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching weather data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    self.weather = weather
                }
            } catch {
                print("Error decoding weather data: \(error)")
            }
        }
        
        task.resume()
    }
}

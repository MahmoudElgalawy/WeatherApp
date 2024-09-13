//
//  HourlyDetailsViewModel.swift
//  firstSwiftUI
//
//  Created by Mahmoud  on 25/08/2024.
//


import Foundation

class HourlyDetailViewModel: ObservableObject {
    @Published var hours: [Hour] = []
    private let apiKey = "08d0035332994f3ba3a223201242308"
    private let urlString = "https://api.weatherapi.com/v1/forecast.json"

    func fetchHourlyWeather(location: String) {
        guard let url = URL(string: "\(urlString)?key=\(apiKey)&q=\(location)&days=1&aqi=yes&alerts=no") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching hourly weather data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    self.hours = weather.forecast?.forecastday?.first?.hour ?? []
                }
            } catch {
                print("Error decoding hourly weather data: \(error)")
            }
        }
        
        task.resume()
    }
}

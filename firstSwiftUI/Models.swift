//
//  Models.swift
//  firstSwiftUI
//
//  Created by Mahmoud  on 24/08/2024.
//
import Foundation

struct Weather: Codable {
    let location: Location?
    let current: Current?
    let forecast: Forecast?
}

struct Location: Codable {
    let name: String?
    let region: String?
    let country: String?
    let lat: Double?
    let lon: Double?
    let tz_id: String?
    let localtime_epoch: Int?
    let localtime: String?
}

struct Current: Codable {
    let temp_c: Double?
    let is_day: Int?
    let condition: Condition?
    let wind_kph: Double?
    let wind_degree: Int?
    let wind_dir: String?
    let pressure_mb: Double?
    let precip_mm: Double?
    let humidity: Int?
    let cloud: Int?
    let feelslike_c: Double?
    let vis_km: Double?
}

struct Condition: Codable {
    let text: String?
    let icon: String?
    let code: Int?
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]?
}

struct ForecastDay: Codable {
    let date: String?
    let date_epoch: Int?
    let day: Day?
    let hour: [Hour]?
}

struct Day: Codable {
    let maxtemp_c: Double?
    let mintemp_c: Double?
    let avgtemp_c: Double?
    let maxwind_kph: Double?
    let totalprecip_mm: Double?
    let avgvis_km: Double?
    let condition: Condition?
}


struct Hour: Codable {
    let time: String
    let temp_c: Double
    let condition: Condition
}

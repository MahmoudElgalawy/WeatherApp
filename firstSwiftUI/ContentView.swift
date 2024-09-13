//
//  ContentView.swift
//  firstSwiftUI
//
//  Created by Mahmoud  on 21/08/2024.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if let weather = viewModel.weather {
                    backgroundView()

                    VStack {
                        topView(
                            location: weather.location?.name ?? "Unknown",
                            currentTemp: weather.current?.temp_c ?? 0.0,
                            condition: weather.current?.condition?.text ?? "Unknown",
                            high: weather.forecast?.forecastday?.first?.day?.maxtemp_c ?? 0.0,
                            low: weather.forecast?.forecastday?.first?.day?.mintemp_c ?? 0.0,
                            iconURL: weather.current?.condition?.icon ?? ""
                        )

                        Spacer().frame(height: 20)

                        forecastView(
                            forecastDays: weather.forecast?.forecastday ?? []
                        )

                        Spacer()

                        bottomView(
                            visibility: weather.current?.vis_km ?? 0.0,
                            humidity: weather.current?.humidity ?? 0,
                            feelsLike: weather.current?.feelslike_c ?? 0.0,
                            pressure: weather.current?.pressure_mb ?? 0.0
                        )
                    }
                    .padding()
                } else {
                    ProgressView("Loading Weather Data...")
                        .onAppear {
                            viewModel.fetchWeather()
                        }
                }
            }
        }
    }

    func backgroundView() -> some View {
        let isDaytime = isDayTime()
        return Image(isDaytime ? "dayImage" : "nightImage")
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }
    
    func isDayTime() -> Bool {
        let currentHour = Calendar.current.component(.hour, from: Date())
        return currentHour >= 5 && currentHour < 18
    }

    func topView(location: String, currentTemp: Double, condition: String, high: Double, low: Double, iconURL: String) -> some View {
        VStack {
            Text(location)
                .font(.system(size: 50))
                .foregroundColor(.black)

            Text("\(currentTemp, specifier: "%.1f")°")
                .font(.system(size: 35))
                .foregroundColor(.black)

            Text(condition)
                .font(.system(size: 35))
                .foregroundColor(.black)

            HStack {
                Text("H: \(high, specifier: "%.1f")°")
                    .foregroundColor(.black)
                    .font(.system(size: 25))
                Text("L: \(low, specifier: "%.1f")°")
                    .foregroundColor(.black)
                    .font(.system(size: 25))
            }
            AsyncImage(url: URL(string: "https:\(iconURL)")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 50)
            } placeholder: {
                ProgressView()
            }
            .foregroundColor(.white)
        }
    }

    func forecastView(forecastDays: [ForecastDay]) -> some View {
        VStack(alignment: .leading) {
            Text("3-DAY FORECAST")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.horizontal, 5)

            ForEach(forecastDays, id: \.date) { day in
                NavigationLink(destination: HourlyDetailView(location: day.date ?? "Unknown")) {
                    HStack {
                        Text(day.date == forecastDays.first?.date ? "Today" : dayOfWeek(from: day.date ?? "Unknown"))
                            .foregroundColor(.black)

                        Spacer()

                        HStack(spacing: 10) {
                            AsyncImage(url: URL(string: "https:\(day.day?.condition?.icon ?? "")")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 30)

                            Text("\(day.day?.mintemp_c ?? 0.0, specifier: "%.1f")° - \(day.day?.maxtemp_c ?? 0.0, specifier: "%.1f")°")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                }
                Divider().background(Color.white)
            }
        }
        .padding(.horizontal, 30)
    }

    func bottomView(visibility: Double, humidity: Int, feelsLike: Double, pressure: Double) -> some View {
        VStack(spacing: 10) {
            HStack(spacing: 30) {
                VStack {
                    Text("Visibility")
                        .foregroundColor(.black)
                        .font(.headline)
                    Text("\(visibility, specifier: "%.1f") km")
                        .font(.title)
                        .foregroundColor(.black)
                        .bold()
                }
                .frame(width: 150, height: 75)
                .padding()

                VStack {
                    Text("Humidity")
                        .foregroundColor(.black)
                        .font(.headline)
                    Text("\(humidity) %")
                        .foregroundColor(.black)
                        .font(.title)
                        .bold()
                }
                .frame(width: 150, height: 75)
                .padding()
            }

            HStack(spacing: 30) {
                VStack {
                    Text("Feels Like")
                        .foregroundColor(.black)
                        .font(.headline)
                    Text("\(feelsLike, specifier: "%.1f")°C")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                }
                .frame(width: 150, height: 75)
                .padding()

                VStack {
                    Text("Pressure")
                        .foregroundColor(.black)
                        .font(.headline)
                    Text("\(pressure, specifier: "%.1f") mb")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                }
                .frame(width: 150, height: 75)
                .padding()
            }
        }
        .foregroundColor(.black)
        .padding()
    }
}

func dayOfWeek(from date: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    if let date = formatter.date(from: date) {
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    return "Unknown"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  HourlyDetails.swift
//  firstSwiftUI
//
//  Created by Mahmoud  on 24/08/2024.
//
import SwiftUI

struct HourlyDetailView: View {
    @StateObject private var viewModel = HourlyDetailViewModel()
    var location: String

    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack {
            backgroundView()

            VStack(alignment: .leading) {
                Text("Hourly Forecast")
                    .font(.system(size: 35))
                    .foregroundColor(.black)
                    .padding(.top, 40)
                    .frame(maxWidth: .infinity, alignment: .center)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(viewModel.hours, id: \.time) { hour in
                            HStack(spacing: 10) {
                                Text(hour.time.split(separator: " ")[1])
                                    .foregroundColor(.black)
                                    .font(.system(size: 22))

                                AsyncImage(url: URL(string: "https:\(hour.condition.icon ?? "")")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 50)

                                Text("\(hour.temp_c, specifier: "%.1f")°")
                                    .foregroundColor(.black)
                                    .font(.system(size: 22))
                            }
                            .padding()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
            .offset(y: 40)
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
            viewModel.fetchHourlyWeather(location: location)
        }
    }

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .font(.system(size: 24))
                .foregroundColor(.black)
        }
        .padding()
    }

    func backgroundView() -> some View {
        Image(isDayTime() ? "dayImage" : "nightImage")
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }

    func isDayTime() -> Bool {
        let currentHour = Calendar.current.component(.hour, from: Date())
        return currentHour >= 5 && currentHour < 18
    }
}

struct HourlyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyDetailView(location: "Cairo")
    }
}

//
//  Backgroundlogic.swift
//  firstSwiftUI
//
//  Created by Mahmoud  on 05/09/2024.
//

import Foundation
import SwiftUI

struct WeatherUtils {
    static func backgroundImage(for isDay: Bool) -> some View {
        Image(isDay ? "dayImage" : "nightImage")
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }

    static func weatherIcon(url: String) -> some View {
        AsyncImage(url: URL(string: "https:\(url)")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 90, height: 50)
    }
}

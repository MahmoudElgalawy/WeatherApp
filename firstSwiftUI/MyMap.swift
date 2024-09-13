//
//  MyMap.swift
//  firstSwiftUI
//
//  Created by Mahmoud  on 21/08/2024.
//

import SwiftUI
import MapKit
struct MyMap: View {
    private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 29.9777, longitude: 31.1325),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    var body: some View {
        Map(initialPosition: .region(region))
    }
}

#Preview {
    MyMap()
}

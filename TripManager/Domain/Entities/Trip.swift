//
//  Trip.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

struct Trip: Identifiable {
    let id: Int
    let description: String
    let driverName: String
    let startTime: Date
    let endTime: Date
    let origin: GeoPoint
    let destination: GeoPoint
    let route: String
    let stops: [Stop]
    let originAddress: String
    let destinationAddress: String
}

//
//  StopDetailed.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

struct DetailedStop {
    let price: Double
    let address: String
    let tripId: Int
    let paid: Bool
    let stopTime: Date
    let point: GeoPoint
    let userName: String
}

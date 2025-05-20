//
//  StopDetailed.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

struct StopDetailed {
    let id: Int
    let point: GeoPoint
    let address: String
    let tripId: Int
    let paid: Bool
    let stopTime: Date?
    let userName: String
    let price: Double
}

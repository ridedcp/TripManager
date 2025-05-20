//
//  DetailedStopDTO.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

struct DetailedStopDTO: Decodable {
    let id: Int
    let tripId: Int
    let userName: String
    let stopTime: String
    let address: String
    let paid: Bool
    let price: Double
    let point: PointDTO
}

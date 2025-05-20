//
//  StopDetailedDTO.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

struct StopDetailedDTO: Decodable {
    let price: Double
    let address: String
    let tripId: Int
    let paid: Bool
    let stopTime: String
    let point: PointDTO
    let userName: String
}


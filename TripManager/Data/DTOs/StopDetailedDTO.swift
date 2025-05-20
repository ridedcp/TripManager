//
//  StopDetailedDTO.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

struct StopDetailedDTO: Decodable {
    let id: Int?
    let point: PointDTO?
    let address: String?
    let tripId: Int?
    let paid: Bool?
    let stopTime: String?
    let userName: String?
    let price: Double?
}


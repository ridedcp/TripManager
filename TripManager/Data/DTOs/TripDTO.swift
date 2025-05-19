//
//  TripDTO.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

struct TripDTO: Decodable {
    let description: String
    let driverName: String
    let startTime: String
    let endTime: String
    let origin: LocationDTO
    let destination: LocationDTO
    let route: String
}

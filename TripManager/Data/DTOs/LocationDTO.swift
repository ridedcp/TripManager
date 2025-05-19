//
//  LocationDTO.swift
//  TripManager
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation

struct LocationDTO: Decodable {
    let address: String
    let point: PointDTO
}

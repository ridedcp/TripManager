//
//  PointDTO.swift
//  TripManager
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation

struct PointDTO: Decodable {
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "_latitude"
        case longitude = "_longitude"
    }
}

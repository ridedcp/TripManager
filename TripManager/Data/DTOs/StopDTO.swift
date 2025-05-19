//
//  StopDTO.swift
//  TripManager
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation

struct StopDTO: Decodable {
    let id: Int?
    let point: PointDTO?
}

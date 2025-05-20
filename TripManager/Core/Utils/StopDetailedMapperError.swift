//
//  StopDetailedMapperError.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

enum StopDetailedMapperError: Error, Equatable {
    case invalidCoordinates
    case invalidDate(String)
}

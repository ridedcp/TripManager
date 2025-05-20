//
//  StopServiceError.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

enum StopServiceError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

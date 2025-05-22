//
//  TripMapperError.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

enum TripMapperError: Error, LocalizedError {
    case invalidDate(String)

    var errorDescription: String? {
        switch self {
        case .invalidDate(let raw):
            return "Invalid date format: \(raw)"
        }
    }
}


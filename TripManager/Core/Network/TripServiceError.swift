//
//  TripServiceError.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

enum TripServiceError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case networkError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The trips URL is invalid."
        case .invalidResponse:
            return "The server response was not valid."
        case .decodingError:
            return "Failed to decode the trips data."
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}


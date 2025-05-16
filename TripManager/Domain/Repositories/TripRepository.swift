//
//  TripRepository.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

protocol TripRepository {
    func getTrips() async throws -> [Trip]
}

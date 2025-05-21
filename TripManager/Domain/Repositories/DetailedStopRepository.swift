//
//  DetailedStopRepository.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

protocol DetailedStopRepository {
    func getDetailedStop() async throws -> DetailedStop
}

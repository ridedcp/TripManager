//
//  StopDetailedRepository.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

protocol StopDetailedRepository {
    func getDetailedStop() async throws -> StopDetailed
}

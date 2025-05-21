//
//  MockIncidentRepository.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 21/5/25.
//

import Foundation
@testable import TripManager

final class MockIncidentRepository: IncidentRepository {
    var incidents: [Incident] = []

    func save(_ incident: Incident) throws {
        incidents.append(incident)
    }

    func getAll() throws -> [Incident] {
        return incidents
    }

    func count() -> Int {
        return incidents.count
    }
}


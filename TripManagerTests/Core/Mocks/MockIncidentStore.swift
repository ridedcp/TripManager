//
//  MockIncidentStore.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 21/5/25.
//

import Foundation
@testable import TripManager

final class MockIncidentStore: IncidentStore {
    var savedIncidents: [Incident] = []
    var storedIncidents: [Incident] = []

    func save(_ incident: Incident) {
        savedIncidents.append(incident)
    }

    func getAll() -> [Incident] {
        return storedIncidents
    }
}

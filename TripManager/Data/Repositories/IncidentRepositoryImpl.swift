//
//  IncidentRepositoryImpl.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

final class IncidentRepositoryImpl: IncidentRepository {
    private let store: IncidentStore

    init(store: IncidentStore) {
        self.store = store
    }

    func save(_ incident: Incident) throws {
        store.save(incident)
    }

    func getAll() throws -> [Incident] {
        store.getAll()
    }

    func count() -> Int {
        store.getAll().count
    }
}


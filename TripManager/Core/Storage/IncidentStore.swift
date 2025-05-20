//
//  IncidentStore.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

protocol IncidentStore {
    func save(_ incident: Incident)
    func getAll() -> [Incident]
}

final class IncidentStoreImpl: IncidentStore {
    private let key = "reported_incidents"

    func save(_ incident: Incident) {
        var current = getAll()
        current.append(incident)
        if let data = try? JSONEncoder().encode(current) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func getAll() -> [Incident] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Incident].self, from: data) else {
            return []
        }
        return decoded
    }
}

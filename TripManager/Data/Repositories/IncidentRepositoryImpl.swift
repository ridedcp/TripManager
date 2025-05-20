//
//  IncidentRepositoryImpl.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

final class IncidentRepositoryImpl: IncidentRepository {
    private let key = "incidents_key"

    func save(_ incident: Incident) throws {
        var all = try getAll()
        all.append(incident)

        let data = try JSONEncoder().encode(all)
        UserDefaults.standard.set(data, forKey: key)
    }

    func getAll() throws -> [Incident] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }

        return try JSONDecoder().decode([Incident].self, from: data)
    }

    func count() -> Int {
        (try? getAll().count) ?? 0
    }
}


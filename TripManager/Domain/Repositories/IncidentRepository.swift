//
//  IncidentRepository.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

protocol IncidentRepository {
    func save(_ incident: Incident) throws
    func getAll() throws -> [Incident]
    func count() -> Int
}


//
//  Incident.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

struct Incident: Codable, Identifiable, Equatable {
    let id: UUID
    let fullName: String
    let email: String
    let phone: String?
    let timestamp: Date
    let description: String
}

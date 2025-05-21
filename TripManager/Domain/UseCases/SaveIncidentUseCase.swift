//
//  SaveIncidentUseCase.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

protocol SaveIncidentUseCase {
    func execute(_ incident: Incident)
}

final class SaveIncidentUseCaseImpl: SaveIncidentUseCase {
    private let repository: IncidentRepository

    init(repository: IncidentRepository) {
        self.repository = repository
    }

    func execute(_ incident: Incident) {
        try? repository.save(incident)
    }
}

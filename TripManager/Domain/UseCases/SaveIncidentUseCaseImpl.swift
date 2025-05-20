//
//  SaveIncidentUseCaseImpl.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

final class SaveIncidentUseCaseImpl: SaveIncidentUseCase {
    private let store: IncidentStore

    init(store: IncidentStore) {
        self.store = store
    }

    func execute(_ incident: Incident) {
        store.save(incident)
    }
}

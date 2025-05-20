//
//  GetIncidentCountUseCaseImpl.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

final class GetIncidentCountUseCaseImpl: GetIncidentCountUseCase {
    private let store: IncidentStore

    init(store: IncidentStore) {
        self.store = store
    }

    func execute() -> Int {
        store.getAll().count
    }
}

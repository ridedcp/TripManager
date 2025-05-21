//
//  GetIncidentCountUseCase.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

protocol GetIncidentCountUseCase {
    func execute() -> Int
}

final class GetIncidentCountUseCaseImpl: GetIncidentCountUseCase {
    private let repository: IncidentRepository

    init(repository: IncidentRepository) {
        self.repository = repository
    }

    func execute() -> Int {
        repository.count()
    }
}

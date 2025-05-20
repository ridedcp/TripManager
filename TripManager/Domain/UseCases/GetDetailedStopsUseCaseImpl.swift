//
//  GetDetailedStopsUseCaseImpl.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

final class GetDetailedStopsUseCaseImpl: GetDetailedStopsUseCase {
    private let repository: StopRepository

    init(repository: StopRepository) {
        self.repository = repository
    }

    func execute() async throws -> [StopDetailed] {
        try await repository.getDetailedStops()
    }
}

//
//  GetDetailedStopsUseCaseImpl.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

final class GetDetailedStopUseCaseImpl: GetDetailedStopUseCase {
    private let repository: DetailedStopRepository

    init(repository: DetailedStopRepository) {
        self.repository = repository
    }

    func execute() async throws -> DetailedStop {
        try await repository.getDetailedStop()
    }
}

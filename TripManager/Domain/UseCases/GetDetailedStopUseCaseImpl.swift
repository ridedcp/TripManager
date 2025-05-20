//
//  GetDetailedStopsUseCaseImpl.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

final class GetDetailedStopUseCaseImpl: GetDetailedStopUseCase {
    private let repository: StopDetailedRepository

    init(repository: StopDetailedRepository) {
        self.repository = repository
    }

    func execute() async throws -> StopDetailed {
        try await repository.getDetailedStop()
    }
}

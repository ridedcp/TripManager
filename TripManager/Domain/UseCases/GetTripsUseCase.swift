//
//  GetTripsUseCase.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

protocol GetTripsUseCase {
    func execute() async throws -> [Trip]
}

final class GetTripsUseCaseImpl: GetTripsUseCase {
    private let repository: TripRepository

    init(repository: TripRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Trip] {
        return try await repository.getTrips()
    }
}

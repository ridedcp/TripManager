//
//  StopDetailedRepositoryImpl.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

final class StopDetailedRepositoryImpl: StopDetailedRepository {
    private let service: StopDetailedService

    init(service: StopDetailedService) {
        self.service = service
    }

    func getDetailedStop() async throws -> DetailedStop {
        let dto = try await service.fetchDetailedStop()
        guard let stop = StopDetailedMapper.map(dto: dto) else {
            throw TripServiceError.decodingError
        }
        return stop
    }
}

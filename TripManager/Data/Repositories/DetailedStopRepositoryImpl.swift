//
//  DetailedStopRepositoryImpl.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

final class DetailedStopRepositoryImpl: DetailedStopRepository {
    private let service: DetailedStopService

    init(service: DetailedStopService) {
        self.service = service
    }

    func getDetailedStop() async throws -> DetailedStop {
        let dto = try await service.fetchDetailedStop()
        guard let stop = DetailedStopMapper.map(dto: dto) else {
            throw TripServiceError.decodingError
        }
        return stop
    }
}

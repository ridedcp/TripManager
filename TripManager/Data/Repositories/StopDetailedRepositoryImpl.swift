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

    func getDetailedStops() async throws -> [StopDetailed] {
        let dtos = try await service.fetchDetailedStops()
        return StopDetailedMapper.mapList(dtos: dtos)
    }
}


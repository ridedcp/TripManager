//
//  TripRepositoryImpl.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

final class TripRepositoryImpl: TripRepository {
    private let service: TripService

    init(service: TripService) {
        self.service = service
    }

    func getTrips() async throws -> [Trip] {
        let dtos = try await service.fetchTrips()
        return try dtos.enumerated().map { index, dto in
            try TripMapper.map(dto: dto, id: index)
        }
    }
}


//
//  MockTripService.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation
@testable import TripManager

final class MockTripService: TripService {
    
    enum ResponseType {
        case success
        case serviceError
        case mapperError
    }
    
    private let responseType: ResponseType

    init(responseType: ResponseType) {
        self.responseType = responseType
    }

    func fetchTrips() async throws -> [TripDTO] {
        switch responseType {
        case .success:
            return [
                TripDTO(
                    description: "Mock trip",
                    driverName: "Mock driver",
                    startTime: "2018-12-18T08:00:00.000Z",
                    endTime: "2018-12-18T09:00:00.000Z"
                )
            ]

        case .serviceError:
            throw TripServiceError.invalidResponse

        case .mapperError:
            return [
                TripDTO(
                    description: "Broken trip",
                    driverName: "Driver",
                    startTime: "not-a-date",
                    endTime: "2018-12-18T09:00:00.000Z"
                )
            ]
        }
    }
}


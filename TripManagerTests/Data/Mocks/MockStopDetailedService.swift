//
//  MockStopDetailedService.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

// Tests/TripManagerTests/Mocks/Services/MockStopDetailedService.swift

import Foundation
@testable import TripManager

enum MockError: Error, Equatable {
    case dummy
}

final class MockStopDetailedService: StopDetailedService {
    enum ResponseType {
        case success
        case failure
    }

    private let responseType: ResponseType

    init(responseType: ResponseType) {
        self.responseType = responseType
    }

    func fetchDetailedStops() async throws -> [StopDetailedDTO] {
        switch responseType {
        case .success:
            return [
                StopDetailedDTO(
                    id: 1,
                    point: PointDTO(latitude: 41.37653, longitude: 2.17924),
                    address: "Ramblas, Barcelona",
                    tripId: 1,
                    paid: true,
                    stopTime: "2018-12-18T08:10:00.000Z",
                    userName: "Manuel Gomez",
                    price: 1.5
                )
            ]
        case .failure:
            throw MockError.dummy
        }
    }
}

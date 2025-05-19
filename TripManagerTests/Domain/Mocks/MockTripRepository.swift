//
//  MockTripRepository.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation
@testable import TripManager

final class MockTripRepository: TripRepository {

    enum ResponseType {
        case success
        case failure
    }

    private let responseType: ResponseType

    init(responseType: ResponseType) {
        self.responseType = responseType
    }

    func getTrips() async throws -> [Trip] {
        switch responseType {
        case .success:
            return [
                Trip(
                    description: "Mock trip",
                    driverName: "Driver",
                    startTime: Date(),
                    endTime: Date()
                )
            ]
        case .failure:
            throw TripServiceError.invalidURL
        }
    }
}


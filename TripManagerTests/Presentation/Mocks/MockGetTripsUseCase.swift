//
//  MockGetTripsUseCase.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation
@testable import TripManager

enum TestError: Error {
    case mock
}

struct MockGetTripsUseCaseSuccess: GetTripsUseCase {
    func execute() async throws -> [Trip] {
        [
            Trip(description: "Barcelona → Martorell", driverName: "Alberto", startTime: Date(), endTime: Date()),
            Trip(description: "Sabadell → Terrassa", driverName: "Daniel", startTime: Date(), endTime: Date())
        ]
    }
}

struct MockGetTripsUseCaseFailure: GetTripsUseCase {
    func execute() async throws -> [Trip] {
        throw TestError.mock
    }
}

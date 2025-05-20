//
//  StopDetailedRepositoryTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

import XCTest
@testable import TripManager

final class StopDetailedRepositoryTests: XCTestCase {

    func test_getDetailedStops_returnsMappedStop() async throws {
        let service = MockStopDetailedService(responseType: .success)
        let repository = StopDetailedRepositoryImpl(service: service)

        let stop = try await repository.getDetailedStop()

        XCTAssertEqual(stop.tripId, 1)
        XCTAssertEqual(stop.userName, "Manuel Gomez")
    }

    func test_getDetailedStops_throwsError() async {
        let service = MockStopDetailedService(responseType: .failure)
        let repository = StopDetailedRepositoryImpl(service: service)

        do {
            _ = try await repository.getDetailedStop()
            XCTFail("Expected error")
        } catch {
            XCTAssertEqual(error as? MockError, .dummy)
        }
    }
}

//
//  DetailedStopRepositoryTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

import XCTest
@testable import TripManager

final class DetailedStopRepositoryTests: XCTestCase {

    func test_getDetailedStops_returnsMappedStop() async throws {
        let service = MockDetailedStopService(responseType: .success)
        let repository = DetailedStopRepositoryImpl(service: service)

        let stop = try await repository.getDetailedStop()

        XCTAssertEqual(stop.tripId, 1)
        XCTAssertEqual(stop.userName, "Manuel Gomez")
    }

    func test_getDetailedStops_throwsError() async {
        let service = MockDetailedStopService(responseType: .failure)
        let repository = DetailedStopRepositoryImpl(service: service)

        do {
            _ = try await repository.getDetailedStop()
            XCTFail("Expected error")
        } catch {
            XCTAssertEqual(error as? MockError, .dummy)
        }
    }
}

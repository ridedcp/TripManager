//
//  GetTripsUseCaseImplTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import XCTest
@testable import TripManager

final class GetTripsUseCaseImplTests: XCTestCase {

    func test_execute_returnsTripsFromRepository() async throws {
        // Given
        let repository = MockTripRepository(responseType: .success)
        let useCase = GetTripsUseCaseImpl(repository: repository)

        // When
        let trips = try await useCase.execute()

        // Then
        XCTAssertEqual(trips.count, 1)
        XCTAssertEqual(trips[0].description, "Mock trip")
    }

    func test_execute_throwsErrorFromRepository() async {
        // Given
        let repository = MockTripRepository(responseType: .failure)
        let useCase = GetTripsUseCaseImpl(repository: repository)

        // When / Then
        do {
            _ = try await useCase.execute()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is TripServiceError)
        }
    }
}


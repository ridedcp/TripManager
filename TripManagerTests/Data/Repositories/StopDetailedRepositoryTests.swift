//
//  StopDetailedRepositoryTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

import XCTest
@testable import TripManager

final class StopDetailedRepositoryTests: XCTestCase {

    func test_getDetailedStops_returnsMappedStops() async throws {
        // Given
        let mockService = MockStopDetailedService(responseType: .success)
        let repository = StopDetailedRepositoryImpl(service: mockService)

        // When
        let result = try await repository.getDetailedStops()

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].userName, "Manuel Gomez")
        XCTAssertEqual(result[0].tripId, 1)
    }
    
    func test_getDetailedStops_throwsErrorOnFailure() async {
        // Given
        let mockService = MockStopDetailedService(responseType: .failure)
        let repository = StopDetailedRepositoryImpl(service: mockService)

        // When / Then
        do {
            _ = try await repository.getDetailedStops()
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertEqual(error as? MockError, .dummy)
        }
    }
}

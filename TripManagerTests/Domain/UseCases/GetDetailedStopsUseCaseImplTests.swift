//
//  GetDetailedStopsUseCaseImplTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

import XCTest
@testable import TripManager

final class GetDetailedStopsUseCaseImplTests: XCTestCase {

    func test_execute_returnsStopsOnSuccess() async throws {
        // Given
        let expectedStops = [
            StopDetailed(
                id: 1,
                point: GeoPoint(latitude: 41.38, longitude: 2.18),
                address: "Barcelona",
                tripId: 1,
                paid: true,
                stopTime: Date(),
                userName: "Daniel",
                price: 1.5
            )
        ]
        let repository = MockStopDetailedRepository(result: .success(expectedStops))
        let useCase = GetDetailedStopsUseCaseImpl(repository: repository)

        // When
        let result = try await useCase.execute()

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].id, expectedStops[0].id)
    }

    func test_execute_throwsErrorOnFailure() async {
        // Given
        let repository = MockStopDetailedRepository(result: .failure(TripServiceError.invalidResponse))
        let useCase = GetDetailedStopsUseCaseImpl(repository: repository)

        // When / Then
        do {
            _ = try await useCase.execute()
            XCTFail("Expected error to be thrown")
        } catch let error as TripServiceError {
            switch error {
            case .invalidResponse:
                // Success
                break
            default:
                XCTFail("Expected .invalidResponse, got \(error)")
            }
        } catch {
            XCTFail("Expected TripServiceError, got \(type(of: error))")
        }
    }
}

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
        let expectedStop =
        DetailedStop(
            price: 1.5,
            address: "Barcelona",
            tripId: 1,
            paid: true,
            stopTime: Date(),
            point: GeoPoint(latitude: 41.38, longitude: 2.18),
            userName: "Daniel"
        )
        
        let repository = MockStopDetailedRepository(result: .success(expectedStop))
        let useCase = GetDetailedStopUseCaseImpl(repository: repository)

        // When
        let result = try await useCase.execute()

        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result.tripId, expectedStop.tripId)
    }

    func test_execute_throwsErrorOnFailure() async {
        // Given
        let repository = MockStopDetailedRepository(result: .failure(TripServiceError.invalidResponse))
        let useCase = GetDetailedStopUseCaseImpl(repository: repository)

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

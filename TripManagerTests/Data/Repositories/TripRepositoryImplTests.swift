//
//  TripRepositoryImplTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import XCTest
@testable import TripManager

final class TripRepositoryImplTests: XCTestCase {

    func test_getTrips_returnsMappedTrips() async throws {
        // Given
        let service = MockTripService(responseType: .success)
        let repository = TripRepositoryImpl(service: service)

        // When
        let trips = try await repository.getTrips()

        // Then
        XCTAssertEqual(trips.count, 1)
        XCTAssertEqual(trips[0].description, "Mock trip")
        XCTAssertEqual(trips[0].driverName, "Mock driver")
    }

    func test_getTrips_throwsServiceError() async {
        // Given
        let service = MockTripService(responseType: .serviceError)
        let repository = TripRepositoryImpl(service: service)

        // When / Then
        do {
            _ = try await repository.getTrips()
            XCTFail("Expected TripServiceError to be thrown")
        } catch {
            XCTAssertTrue(error is TripServiceError)
        }
    }

    func test_getTrips_throwsMapperError() async {
        // Given
        let service = MockTripService(responseType: .mapperError)
        let repository = TripRepositoryImpl(service: service)

        // When / Then
        do {
            _ = try await repository.getTrips()
            XCTFail("Expected TripMapperError to be thrown")
        } catch {
            XCTAssertTrue(error is TripMapperError)
        }
    }
}



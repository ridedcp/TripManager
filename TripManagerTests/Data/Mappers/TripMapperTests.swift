//
//  TripMapperTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import XCTest
@testable import TripManager

final class TripMapperTests: XCTestCase {
    
    func test_map_validDTO_returnsTrip() throws {
        // Given
        let dto = TripDTO(
            description: "Test Trip",
            driverName: "Daniel",
            startTime: "2018-12-18T08:00:00.000Z",
            endTime: "2018-12-18T09:00:00.000Z"
        )

        // When
        let trip = try TripMapper.map(dto: dto)

        // Then
        XCTAssertEqual(trip.description, dto.description)
        XCTAssertEqual(trip.driverName, dto.driverName)
    }
    
    func test_map_invalidDate_throwsError() throws {
        // Given
        let dto = TripDTO(
            description: "Invalid Trip",
            driverName: "Test",
            startTime: "invalid-date",
            endTime: "2018-12-18T09:00:00.000Z"
        )

        // When / Then
        XCTAssertThrowsError(try TripMapper.map(dto: dto)) { error in
            XCTAssertTrue(error is TripMapperError)
        }
    }
}


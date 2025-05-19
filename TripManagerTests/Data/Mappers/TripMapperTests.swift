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
    
    func test_map_validDTO_returnsTripWithCorrectFields() throws {
        // Given
        let dto = TripDTO(
            description: "Test Trip",
            driverName: "Driver 1",
            startTime: "2018-12-18T08:00:00.000Z",
            endTime: "2018-12-18T09:00:00.000Z"
        )

        // When
        let trip = try TripMapper.map(dto: dto)

        // Then
        XCTAssertEqual(trip.description, dto.description)
        XCTAssertEqual(trip.driverName, dto.driverName)

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let expectedStart = formatter.date(from: dto.startTime),
              let expectedEnd = formatter.date(from: dto.endTime) else {
            return XCTFail("Failed to parse date in test setup")
        }

        XCTAssertEqual(trip.startTime.timeIntervalSince1970, expectedStart.timeIntervalSince1970, accuracy: 0.1)
        XCTAssertEqual(trip.endTime.timeIntervalSince1970, expectedEnd.timeIntervalSince1970, accuracy: 0.1)
    }
    
    func test_map_invalidStartTime_throwsInvalidDateError() {
        // Given
        let dto = TripDTO(
            description: "Invalid Start",
            driverName: "Driver",
            startTime: "not-a-date",
            endTime: "2018-12-18T09:00:00.000Z"
        )

        // When / Then
        XCTAssertThrowsError(try TripMapper.map(dto: dto)) { error in
            guard case TripMapperError.invalidDate(let value) = error else {
                return XCTFail("Expected invalidDate, got \(error)")
            }
            XCTAssertEqual(value, dto.startTime)
        }
    }

    func test_map_invalidEndTime_throwsInvalidDateError() {
        // Given
        let dto = TripDTO(
            description: "Invalid End",
            driverName: "Driver",
            startTime: "2018-12-18T08:00:00.000Z",
            endTime: "wrong-end-time"
        )

        // When / Then
        XCTAssertThrowsError(try TripMapper.map(dto: dto)) { error in
            guard case TripMapperError.invalidDate(let value) = error else {
                return XCTFail("Expected invalidDate, got \(error)")
            }
            XCTAssertEqual(value, dto.endTime)
        }
    }
}


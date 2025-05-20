//
//  StopDetailedMapperTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

import XCTest
@testable import TripManager

final class StopDetailedMapperTests: XCTestCase {

    func test_mapList_mapsValidDTOCorrectly() {
        // Given
        let dto = StopDetailedDTO(
            id: 1,
            point: PointDTO(latitude: 41.37653, longitude: 2.17924),
            address: "Ramblas, Barcelona",
            tripId: 1,
            paid: true,
            stopTime: "2018-12-18T08:10:00.000Z",
            userName: "Manuel Gomez",
            price: 1.5
        )

        // When
        let result = StopDetailedMapper.mapList(dtos: [dto])

        // Then
        XCTAssertEqual(result.count, 1)

        let stop = result[0]

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let expectedDate = formatter.date(from: "2018-12-18T08:10:00.000Z")
        XCTAssertNotNil(expectedDate)

        XCTAssertEqual(stop.id, 1)
        XCTAssertEqual(stop.point.latitude, 41.37653, accuracy: 0.0001)
        XCTAssertEqual(stop.point.longitude, 2.17924, accuracy: 0.0001)
        XCTAssertEqual(stop.address, "Ramblas, Barcelona")
        XCTAssertEqual(stop.tripId, 1)
        XCTAssertEqual(stop.paid, true)
        XCTAssertEqual(stop.userName, "Manuel Gomez")
        XCTAssertEqual(stop.price, 1.5)

        if let stopTime = stop.stopTime, let expected = expectedDate {
            XCTAssertEqual(stopTime.timeIntervalSince1970, expected.timeIntervalSince1970, accuracy: 0.1)
        } else {
            XCTFail("stopTime or expectedDate is nil")
        }
    }

    func test_mapList_skipsInvalidDTOs() {
        // Given: Missing required fields
        let invalidDTO = StopDetailedDTO(
            id: nil,
            point: nil,
            address: nil,
            tripId: nil,
            paid: nil,
            stopTime: nil,
            userName: nil,
            price: nil
        )

        // When
        let result = StopDetailedMapper.mapList(dtos: [invalidDTO])

        // Then
        XCTAssertTrue(result.isEmpty)
    }
}

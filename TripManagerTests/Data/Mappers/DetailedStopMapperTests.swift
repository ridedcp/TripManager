//
//  DetailedStopMapperTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

import XCTest
@testable import TripManager

final class DetailedStopMapperTests: XCTestCase {

    func test_map_validDTO_returnsDetailedStop() {
        // Given
        let dto = DetailedStopDTO(
            price: 1.5,
            address: "Ramblas, Barcelona",
            tripId: 1,
            paid: true,
            stopTime: "2018-12-18T08:10:00.000Z",
            point: PointDTO(latitude: 41.37653, longitude: 2.17924),
            userName: "Manuel Gomez"
        )

        // When
        let result = DetailedStopMapper.map(dto: dto)

        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.tripId, 1)
        XCTAssertEqual(result?.address, "Ramblas, Barcelona")
        XCTAssertEqual(result?.userName, "Manuel Gomez")
        XCTAssertEqual(result?.price, 1.5)
        XCTAssertEqual(result?.paid, true)

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let expectedDate = formatter.date(from: "2018-12-18T08:10:00.000Z")

        if let stopTime = result?.stopTime, let expected = expectedDate {
            XCTAssertEqual(stopTime.timeIntervalSince1970, expected.timeIntervalSince1970, accuracy: 0.1)
        } else {
            XCTFail("stopTime or expectedDate is nil")
        }
    }

    func test_map_invalidDate_returnsNil() {
        // Given
        let dto = DetailedStopDTO(
            price: 1.5,
            address: "Ramblas, Barcelona",
            tripId: 1,
            paid: true,
            stopTime: "invalid-date",
            point: PointDTO(latitude: 41.37653, longitude: 2.17924),
            userName: "Manuel Gomez"
        )

        // When
        let result = DetailedStopMapper.map(dto: dto)

        // Then
        XCTAssertNil(result, "Expected nil due to invalid date")
    }
}

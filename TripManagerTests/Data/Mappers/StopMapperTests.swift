//
//  StopMapperTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import XCTest
@testable import TripManager

final class StopMapperTests: XCTestCase {

    func test_mapList_returnsStops_whenPointsAreValid() {
        // Given
        let dtos = [
            StopDTO(id: 1, point: PointDTO(latitude: 41.1, longitude: 2.1)),
            StopDTO(id: 2, point: PointDTO(latitude: 41.2, longitude: 2.2))
        ]

        // When
        let result = StopMapper.mapList(dtos: dtos)

        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].id, 1)
        XCTAssertEqual(result[1].point.latitude, 41.2)
    }

    func test_mapList_skipsStopsWithoutPoint() {
        // Given
        let dtos = [
            StopDTO(id: 1, point: nil),
            StopDTO(id: 2, point: PointDTO(latitude: 41.2, longitude: 2.2))
        ]

        // When
        let result = StopMapper.mapList(dtos: dtos)

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].id, 2)
        XCTAssertEqual(result[0].point.longitude, 2.2)
    }

    func test_mapList_generatesIdWhenMissing() {
        // Given
        let dtos = [
            StopDTO(id: nil, point: PointDTO(latitude: 41.3, longitude: 2.3))
        ]

        // When
        let result = StopMapper.mapList(dtos: dtos)

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].id, 1) // index + 1
        XCTAssertEqual(result[0].point.latitude, 41.3)
    }
}

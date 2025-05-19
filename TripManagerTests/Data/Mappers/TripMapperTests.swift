//
//  TripMapperTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import XCTest
@testable import TripManager

final class TripMapperTests: XCTestCase {
    
    private let validOrigin = LocationDTO(address: "Origen", point: PointDTO(latitude: 41.0, longitude: 2.0))
    private let validDestination = LocationDTO(address: "Destino", point: PointDTO(latitude: 42.0, longitude: 3.0))

    private let route = "abc123"

    func test_map_validDTO_returnsTrip() throws {
        // Given
        let dto = TripDTO(
            description: "Test Trip",
            driverName: "Daniel",
            startTime: "2018-12-18T08:00:00.000Z",
            endTime: "2018-12-18T09:00:00.000Z",
            origin: validOrigin,
            destination: validDestination,
            route: route,
            stops: nil
        )

        // When
        let trip = try TripMapper.map(dto: dto)

        // Then
        XCTAssertEqual(trip.description, dto.description)
        XCTAssertEqual(trip.driverName, dto.driverName)
        XCTAssertEqual(trip.route, dto.route)
        XCTAssertEqual(trip.origin.latitude, validOrigin.point.latitude)
        XCTAssertEqual(trip.destination.longitude, validDestination.point.longitude)
    }
    
    func test_map_invalidDate_throwsError() throws {
        // Given
        let dto = TripDTO(
            description: "Invalid Trip",
            driverName: "Test",
            startTime: "invalid-date",
            endTime: "2018-12-18T09:00:00.000Z",
            origin: validOrigin,
            destination: validDestination,
            route: route,
            stops: nil
        )

        // When / Then
        XCTAssertThrowsError(try TripMapper.map(dto: dto)) {
            XCTAssertTrue($0 is TripMapperError)
        }
    }
    
    func test_map_validDTO_returnsTripWithCorrectFields() throws {
        // Given
        let dto = TripDTO(
            description: "Test Trip",
            driverName: "Driver 1",
            startTime: "2018-12-18T08:00:00.000Z",
            endTime: "2018-12-18T09:00:00.000Z",
            origin: validOrigin,
            destination: validDestination,
            route: route,
            stops: nil
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
            endTime: "2018-12-18T09:00:00.000Z",
            origin: validOrigin,
            destination: validDestination,
            route: route,
            stops: nil
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
            endTime: "wrong-end-time",
            origin: validOrigin,
            destination: validDestination,
            route: route,
            stops: nil
        )

        // When / Then
        XCTAssertThrowsError(try TripMapper.map(dto: dto)) { error in
            guard case TripMapperError.invalidDate(let value) = error else {
                return XCTFail("Expected invalidDate, got \(error)")
            }
            XCTAssertEqual(value, dto.endTime)
        }
    }

    func test_map_includesMappedStops_whenPresent() throws {
        // Given
        let stops: [StopDTO] = [
            StopDTO(id: 1, point: PointDTO(latitude: 41.1, longitude: 2.1)),
            StopDTO(id: 2, point: PointDTO(latitude: 41.2, longitude: 2.2))
        ]
        
        let dto = TripDTO(
            description: "With Stops",
            driverName: "Test",
            startTime: "2018-12-18T08:00:00.000Z",
            endTime: "2018-12-18T09:00:00.000Z",
            origin: validOrigin,
            destination: validDestination,
            route: route,
            stops: stops
        )

        // When
        let trip = try TripMapper.map(dto: dto)

        // Then
        XCTAssertEqual(trip.stops.count, 2)
        XCTAssertEqual(trip.stops[0].id, 1)
        XCTAssertEqual(trip.stops[1].point.latitude, 41.2)
    }

    func test_map_filtersInvalidStops_whenPointIsMissing() throws {
        // Given
        let stops: [StopDTO] = [
            StopDTO(id: 1, point: nil),
            StopDTO(id: 2, point: PointDTO(latitude: 41.2, longitude: 2.2))
        ]

        let dto = TripDTO(
            description: "With Invalid Stop",
            driverName: "Test",
            startTime: "2018-12-18T08:00:00.000Z",
            endTime: "2018-12-18T09:00:00.000Z",
            origin: validOrigin,
            destination: validDestination,
            route: route,
            stops: stops
        )

        // When
        let trip = try TripMapper.map(dto: dto)

        // Then
        XCTAssertEqual(trip.stops.count, 1)
        XCTAssertEqual(trip.stops[0].id, 2)
    }
}

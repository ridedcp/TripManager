//
//  RouteDecoderTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import XCTest
import CoreLocation
@testable import TripManager

final class RouteDecoderTests: XCTestCase {

    func test_decodePolyline_returnsExpectedCoordinates() {
        // Given
        let encoded = "_p~iF~ps|U_ulLnnqC_mqNvxq`@"

        // When
        let coordinates = RouteDecoder.decodePolyline(encoded)

        // Then
        XCTAssertFalse(coordinates.isEmpty)
        XCTAssertEqual(coordinates.count, 3)
    }

    func test_decodePolyline_returnsEmpty_whenInvalidInput() {
        // Given
        let encoded = "!!invalid!!"

        // When
        let coordinates = RouteDecoder.decodePolyline(encoded)

        // Then
        XCTAssertTrue(coordinates.isEmpty)
    }
}


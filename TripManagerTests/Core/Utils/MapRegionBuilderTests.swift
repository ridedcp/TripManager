//
//  MapRegionBuilderTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import XCTest
import MapKit
@testable import TripManager

final class MapRegionBuilderTests: XCTestCase {

    func test_regionFitting_returnsExpectedRegion_withPadding() {
        // Given
        let origin = GeoPoint(latitude: 41.38, longitude: 2.18)
        let destination = GeoPoint(latitude: 41.40, longitude: 2.16)

        // When
        let region = MapRegionBuilder.regionFitting(origin: origin, destination: destination)

        // Then
        let expectedCenterLat = (origin.latitude + destination.latitude) / 2
        let expectedCenterLon = (origin.longitude + destination.longitude) / 2

        XCTAssertEqual(region.center.latitude, expectedCenterLat, accuracy: 0.0001)
        XCTAssertEqual(region.center.longitude, expectedCenterLon, accuracy: 0.0001)
        XCTAssertTrue(region.span.latitudeDelta > 0)
        XCTAssertTrue(region.span.longitudeDelta > 0)
    }
}


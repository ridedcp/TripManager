//
//  TripMapViewModelTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 21/5/25.
//

import XCTest
import MapKit
@testable import TripManager

@MainActor
final class TripMapViewModelTests: XCTestCase {

    func test_loadDetailedStop_setsStopCorrectly() async throws {
        // Given
        let expectedStop = DetailedStop(
            price: 1.5,
            address: "Ramblas, Barcelona",
            tripId: 1,
            paid: true,
            stopTime: Date(),
            point: GeoPoint(latitude: 41.37653, longitude: 2.17924),
            userName: "Manuel Gomez"
        )

        let useCase = MockGetDetailedStopUseCase(result: .success(expectedStop))
        let viewModel = TripMapViewModel(getDetailedStopUseCase: useCase)

        // When
        await viewModel.loadDetailedStop()

        // Then
        XCTAssertEqual(viewModel.detailedStop?.userName, "Manuel Gomez")
        XCTAssertEqual(viewModel.detailedStop?.price, 1.5)
    }

    func test_loadDetailedStop_setsNilOnFailure() async {
        // Given
        let useCase = MockGetDetailedStopUseCase(result: .failure(MockError.dummy))
        let viewModel = TripMapViewModel(getDetailedStopUseCase: useCase)

        // When
        await viewModel.loadDetailedStop()

        // Then
        XCTAssertNil(viewModel.detailedStop)
    }

    func test_decodePolyline_decodesCorrectly() async {
        // Given
        let viewModel = TripMapViewModel(getDetailedStopUseCase: MockGetDetailedStopUseCase(result: .failure(MockError.dummy)))
        let encodedPolyline = "uxw{F}lcLvwByv@byAnqF"

        // When
        viewModel.decodePolyline(encodedPolyline)

        // Then
        XCTAssertFalse(viewModel.routeCoordinates.isEmpty)
    }
}


//Website to get encodedPolyline
//https://developers.google.com/maps/documentation/utilities/polylineutility?hl=es-419

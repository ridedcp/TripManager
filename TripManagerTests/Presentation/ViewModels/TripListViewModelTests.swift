//
//  TripListViewModelTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import XCTest
@testable import TripManager

final class TripListViewModelTests: XCTestCase {

    private func makeSUT(responseType: MockGetTripsUseCase.ResponseType, incidentCount: Int = 1) async -> TripListViewModel {
        let getTripsUseCase = MockGetTripsUseCase(responseType: responseType)
        let getIncidentCountUseCase = MockGetIncidentCountUseCase(count: incidentCount)
        let setBadgeCountUseCase = MockSetBadgeCountUseCase()
        
        return await TripListViewModel(
            getTripsUseCase: getTripsUseCase,
            getIncidentCountUseCase: getIncidentCountUseCase,
            setBadgeCountUseCase: setBadgeCountUseCase
        )
    }

    // MARK: - Tests

    func test_loadTrips_successfullyUpdatesTrips() async throws {
        // Given
        let viewModel = await makeSUT(responseType: .success)

        // When
        await viewModel.loadTrips()

        // Then
        await MainActor.run {
            XCTAssertEqual(viewModel.trips.count, 2, "Expected 2 trips")
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
        }
    }

    func test_loadTrips_setsErrorMessageOnFailure() async throws {
        // Given
        let viewModel = await makeSUT(responseType: .failure)

        // When
        await viewModel.loadTrips()

        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.trips.isEmpty)
        }
    }
    
    func test_loadTrips_withTwoTrips_returnsCorrectCount() async {
        // Given
        let viewModel = await makeSUT(responseType: .success)
        
        // When
        await viewModel.loadTrips()
        
        // Then
        await MainActor.run {
            XCTAssertEqual(viewModel.trips.count, 2, "Expected 2 trips but got \(viewModel.trips.count)")
            XCTAssertNil(viewModel.errorMessage, "Expected no error message")
            XCTAssertFalse(viewModel.isLoading, "Expected loading to be false")
        }
    }
    
    func test_loadTrips_withFailure_setsErrorMessage() async {
        // Given
        let viewModel = await makeSUT(responseType: .failure)

        // When
        await viewModel.loadTrips()

        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.trips.isEmpty, "Expected no trips")
            XCTAssertFalse(viewModel.isLoading, "Expected loading to be false")
        }
    }
}

//
//  TripListViewModelTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import XCTest
@testable import TripManager

final class TripListViewModelTests: XCTestCase {
    
    // MARK: - Helpers
    
    private func makeSUT(using useCase: GetTripsUseCase) async -> TripListViewModel {
        await TripListViewModel(getTripsUseCase: useCase)
    }

    // MARK: - Tests

    func test_loadTrips_successfullyUpdatesTrips() async throws {
        // Given
        let viewModel = await makeSUT(using: MockGetTripsUseCaseSuccess())

        // When
        await viewModel.loadTrips()

        // Then
        await MainActor.run {
            XCTAssertEqual(viewModel.trips.count, 2, "Expected 2 trips but got \(viewModel.trips.count)")
            XCTAssertNil(viewModel.errorMessage, "Expected no error message")
            XCTAssertFalse(viewModel.isLoading, "Expected isLoading to be false")
        }
    }

    func test_loadTrips_setsErrorMessageOnFailure() async throws {
        // Given
        let viewModel = await makeSUT(using: MockGetTripsUseCaseFailure())

        // When
        await viewModel.loadTrips()

        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.trips.isEmpty, "Expected trips to be empty on failure")
            XCTAssertEqual(viewModel.errorMessage, "Failed to load trips")
        }
    }
}

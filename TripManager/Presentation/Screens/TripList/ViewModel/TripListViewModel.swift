//
//  TripListViewModel.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

@MainActor
final class TripListViewModel: ObservableObject {
    @Published var trips: [Trip] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let getTripsUseCase: GetTripsUseCase

    init(getTripsUseCase: GetTripsUseCase) {
        self.getTripsUseCase = getTripsUseCase
    }

    func loadTrips() async {
        isLoading = true
        do {
            trips = try await getTripsUseCase.execute()
        } catch {
            errorMessage = "Failed to load trips"
        }
        isLoading = false
    }
}

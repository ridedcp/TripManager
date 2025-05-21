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
    @Published var incidentCount: Int = 0

    private let getTripsUseCase: GetTripsUseCase
    private let getIncidentCountUseCase: GetIncidentCountUseCase
    private let setBadgeCountUseCase: SetBadgeCountUseCase

    init(
        getTripsUseCase: GetTripsUseCase,
        getIncidentCountUseCase: GetIncidentCountUseCase,
        setBadgeCountUseCase: SetBadgeCountUseCase
    ) {
        self.getTripsUseCase = getTripsUseCase
        self.getIncidentCountUseCase = getIncidentCountUseCase
        self.setBadgeCountUseCase = setBadgeCountUseCase
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

    func loadIncidentCount() {
        incidentCount = getIncidentCountUseCase.execute()
        setBadgeCountUseCase.execute(incidentCount)
    }
}

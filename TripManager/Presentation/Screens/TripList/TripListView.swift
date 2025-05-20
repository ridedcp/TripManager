//
//  TripListView.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import SwiftUI

import SwiftUI

struct TripListView: View {
    @StateObject var viewModel: TripListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.trips, id: \.id) { trip in
                NavigationLink(
                    destination: TripMapView(
                        trip: trip,
                        viewModel: TripMapViewModel(
                            getDetailedStopsUseCase: GetDetailedStopsUseCaseImpl(
                                repository: StopDetailedRepositoryImpl(
                                    service: StopDetailedServiceImpl()
                                )
                            )
                        )
                    )
                ) {
                    VStack(alignment: .leading) {
                        Text(trip.description)
                            .font(.headline)
                        Text("Driver: \(trip.driverName)")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Trips")
            .task {
                await viewModel.loadTrips()
            }
        }
    }
}

#Preview {
    TripListView(viewModel: TripListViewModel(getTripsUseCase: FakeGetTripsUseCase()))
}

final class FakeGetTripsUseCase: GetTripsUseCase {
    func execute() async throws -> [Trip] {
        [
            Trip(
                id: 1,
                description: "Preview Trip",
                driverName: "Preview Driver",
                startTime: Date(),
                endTime: Date().addingTimeInterval(1800),
                origin: GeoPoint(latitude: 41.38, longitude: 2.18),
                destination: GeoPoint(latitude: 41.39, longitude: 2.16),
                route: "abc123",
                stops: [
                    Stop(id: 1, point: GeoPoint(latitude: 41.385, longitude: 2.175)),
                    Stop(id: 2, point: GeoPoint(latitude: 41.387, longitude: 2.170)),
                    Stop(id: 3, point: GeoPoint(latitude: 41.388, longitude: 2.165))
                ],
                originAddress: "some origin",
                destinationAddress: "some destination"
            )
        ]
    }
}

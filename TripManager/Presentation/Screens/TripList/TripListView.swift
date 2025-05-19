//
//  TripListView.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import SwiftUI

struct TripListView: View {
    @StateObject var viewModel: TripListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.trips, id: \.description) { trip in
                NavigationLink(destination: TripMapView(trip: trip)) {
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
                description: "Preview Trip",
                driverName: "Preview Driver",
                startTime: Date(),
                endTime: Date().addingTimeInterval(1800),
                origin: GeoPoint(latitude: 41.38, longitude: 2.18),
                destination: GeoPoint(latitude: 41.39, longitude: 2.16),
                route: "abc123"
            )
        ]
    }
}

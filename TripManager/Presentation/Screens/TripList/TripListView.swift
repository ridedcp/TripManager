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
                VStack(alignment: .leading) {
                    Text(trip.description)
                        .font(.headline)
                    Text("Driver: \(trip.driverName)")
                        .font(.subheadline)
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
    TripListView(viewModel: TripListViewModel(getTripsUseCase: MockGetTripsUseCase()))
}

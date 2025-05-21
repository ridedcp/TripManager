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
            List(viewModel.trips, id: \.id) { trip in
                NavigationLink(
                    destination: TripMapView(
                        trip: trip,
                        viewModel: TripMapViewModel(
                            getDetailedStopUseCase: GetDetailedStopUseCaseImpl(
                                repository: DetailedStopRepositoryImpl(
                                    service: DetailedStopServiceImpl()
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ZStack {
                        Image(systemName: "exclamationmark.bubble")
                        if viewModel.incidentCount > 0 {
                            Text("\(viewModel.incidentCount)")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10)
                        }
                    }
                }
            }
            .task {
                await viewModel.loadTrips()
                viewModel.loadIncidentCount()
            }
        }
    }
}

#Preview {
    TripListView(viewModel: TripListViewModel(getTripsUseCase: GetTripsUseCaseImpl(repository: TripRepositoryImpl(service: TripServiceImpl(session: URLSession.shared))), getIncidentCountUseCase: GetIncidentCountUseCaseImpl(repository: IncidentRepositoryImpl(store: IncidentStoreImpl())), setBadgeCountUseCase: SetBadgeCountUseCaseImpl()))
}

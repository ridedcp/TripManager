//
//  TripListView.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import SwiftUI

struct TripListView: View {
    @StateObject var viewModel: TripListViewModel
    let diContainer: AppDIContainer
    @State private var showContactForm = false

    var body: some View {
        NavigationView {
            List(viewModel.trips) { trip in
                NavigationLink(
                    destination: TripMapView(
                        trip: trip,
                        viewModel: diContainer.makeTripMapViewModel()
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
            .listStyle(.plain)
            .navigationTitle("Trips")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showContactForm = true
                    } label: {
                        ZStack {
                            Image(systemName: "exclamationmark.bubble")
                                .accessibilityIdentifier("contactFormButton")
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
            }
            .sheet(isPresented: $showContactForm) {
                ContactFormView(
                    viewModel: diContainer.makeContactFormViewModel(),
                    onDismiss: {
                        showContactForm = false
                        viewModel.loadIncidentCount()
                    }
                )
            }
            .task {
                await viewModel.loadTrips()
                viewModel.loadIncidentCount()
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}

#Preview {
    TripListView(
        viewModel: AppDIContainer().makeTripListViewModel(),
        diContainer: AppDIContainer()
    )
}

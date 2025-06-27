//
//  TripMapView.swift
//  TripManager
//
//  Created by Daniel Cano on 19/5/25.
//

import SwiftUI
import MapKit

struct TripMapView: View {
    let trip: Trip

    @StateObject var viewModel: TripMapViewModel
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var selectedMarker: SelectedMarker?

    var body: some View {
        VStack(spacing: 0) {
            Map(initialPosition: cameraPosition) {
                Annotation("Start", coordinate: trip.origin.toCoord()) {
                    MapPinView(color: .green)
                        .accessibilityIdentifier("startPin")
                        .onTapGesture {
                            selectedMarker = .start
                        }
                }

                Annotation("End", coordinate: trip.destination.toCoord()) {
                    MapPinView(color: .red)
                        .accessibilityIdentifier("endPin")
                        .onTapGesture {
                            selectedMarker = .end
                        }
                }

                ForEach(Array(trip.stops.enumerated()), id: \.1.id) { index, stop in
                    Annotation("Stop \(index + 1)", coordinate: stop.point.toCoord()) {
                        MapPinView(color: .blue)
                            .accessibilityIdentifier("stopPin\(index + 1)")
                            .onTapGesture {
                                selectedMarker = .stop(index + 1)
                            }
                    }
                }

                if !viewModel.routeCoordinates.isEmpty {
                    MapPolyline(coordinates: viewModel.routeCoordinates)
                        .stroke(.blue, lineWidth: 4)
                }
            }
            .accessibilityIdentifier("tripMap")
            .frame(maxHeight: .infinity)
            .onAppear {
                cameraPosition = .region(
                    MapRegionBuilder.regionFitting(
                        origin: trip.origin,
                        destination: trip.destination,
                        stops: trip.stops.map { $0.point }
                    )
                )
                viewModel.decodePolyline(trip.route)
                Task { await viewModel.loadDetailedStop() }
            }

            TripInfoFooterView(trip: trip)
        }
        .sheet(item: $selectedMarker) { _ in
            DetailsStopSheet(trip: trip, stop: viewModel.detailedStop)
        }
    }
}

#Preview {
    TripMapView(
        trip: FakeTripMapData.previewTrip,
        viewModel: TripMapViewModel(getDetailedStopUseCase: FakeGetDetailedStopUseCase())
    )
}

final class FakeGetDetailedStopUseCase: GetDetailedStopUseCase {
    func execute() async throws -> DetailedStop {
        return DetailedStop(price: 0.0, address: "", tripId: 0, paid: false, stopTime: Date(), point: GeoPoint(latitude: 0.0, longitude: 0.0), userName: "")
    }
}

private struct FakeTripMapData {
    static let previewTrip = Trip(
        id: 1,
        description: "Preview Trip",
        driverName: "Driver Preview",
        startTime: Date(),
        endTime: Date().addingTimeInterval(1800),
        origin: GeoPoint(latitude: 41.38074, longitude: 2.18594),
        destination: GeoPoint(latitude: 41.39664, longitude: 2.16073),
        route: "c~fpH_ibE??a@?c@Be@B]B]BQ@K@Q@a@Bc@Be@",
        stops: [
            Stop(id: 1, point: GeoPoint(latitude: 41.385, longitude: 2.175)),
            Stop(id: 2, point: GeoPoint(latitude: 41.387, longitude: 2.170)),
            Stop(id: 3, point: GeoPoint(latitude: 41.388, longitude: 2.165))
        ],
        originAddress: "some origin",
        destinationAddress: "some destination"
    )
}

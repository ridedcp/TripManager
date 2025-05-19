//
//  TripMapView.swift
//  TripManager
//
//  Created by Daniel Cano on 19/5/25.
//

import SwiftUI
import MapKit
import Polyline

struct TripMapView: View {
    let trip: Trip

    @State private var routeCoordinates: [CLLocationCoordinate2D] = []
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $cameraPosition) {
            Marker("Start", coordinate: CLLocationCoordinate2D(latitude: trip.origin.latitude, longitude: trip.origin.longitude))
            Marker("End", coordinate: CLLocationCoordinate2D(latitude: trip.destination.latitude, longitude: trip.destination.longitude))

            if !routeCoordinates.isEmpty {
                MapPolyline(coordinates: routeCoordinates)
                    .stroke(.blue, lineWidth: 4)
            }
        }
        .onAppear {
            cameraPosition = .region(MapRegionBuilder.regionFitting(origin: trip.origin, destination: trip.destination))
            routeCoordinates = RouteDecoder.decodePolyline(trip.route)
        }
    }
}

#Preview {
    TripMapView(trip: FakeTripMapData.previewTrip)
}

private struct FakeTripMapData {
    static let previewTrip = Trip(
        description: "Preview Trip",
        driverName: "Driver Preview",
        startTime: Date(),
        endTime: Date().addingTimeInterval(1800),
        origin: GeoPoint(latitude: 41.38074, longitude: 2.18594),
        destination: GeoPoint(latitude: 41.39664, longitude: 2.16073),
        route: "c~fpH_ibE??a@?c@Be@B]B]BQ@K@Q@a@Bc@Be@"
    )
}

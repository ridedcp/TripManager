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
    @State private var selectedMarker: SelectedMarker?

    var body: some View {
        VStack(spacing: 0) {
            Map(position: $cameraPosition) {
                Annotation("Start", coordinate: CLLocationCoordinate2D(latitude: trip.origin.latitude, longitude: trip.origin.longitude)) {
                    MapPinView(color: .green)
                        .onTapGesture {
                            selectedMarker = .start
                        }
                }
                
                Annotation("End", coordinate: CLLocationCoordinate2D(latitude: trip.destination.latitude, longitude: trip.destination.longitude)) {
                    MapPinView(color: .red)
                        .onTapGesture {
                            selectedMarker = .end
                        }
                }
                
                ForEach(Array(trip.stops.enumerated()), id: \.1.id) { index, stop in
                    let coord = CLLocationCoordinate2D(latitude: stop.point.latitude, longitude: stop.point.longitude)
                    Annotation("Stop \(index + 1)", coordinate: coord) {
                        MapPinView(color: .blue)
                            .onTapGesture {
                                selectedMarker = .stop(index + 1)
                            }
                    }
                }
                
                if !routeCoordinates.isEmpty {
                    MapPolyline(coordinates: routeCoordinates)
                        .stroke(.blue, lineWidth: 4)
                }
            }
            .frame(maxHeight: .infinity)
            .onAppear {
                cameraPosition = .region(
                    MapRegionBuilder.regionFitting(
                        origin: trip.origin,
                        destination: trip.destination,
                        stops: trip.stops.map { $0.point }
                    )
                )
                routeCoordinates = RouteDecoder.decodePolyline(trip.route)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(trip.description)
                    .font(.headline)
                
                Text("Driver: \(trip.driverName)")
                    .font(.subheadline)
                
                Text("From \(formattedDate(trip.startTime)) to \(formattedDate(trip.endTime))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack {
                    if trip.stops.isEmpty {
                        Text("No stops")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Stops: \(trip.stops.count)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.thinMaterial)
        }
        .sheet(item: $selectedMarker) { marker in
            VStack(spacing: 12) {
                Text(marker.title)
                    .font(.headline)
                    .padding(.top)
                
                Divider()
                
                switch marker {
                case .start:
                    Text(trip.originAddress)
                        .font(.body)
                    VStack(spacing: 8) {
                        Text("Lat: \(trip.origin.latitude, specifier: "%.5f")")
                        Text("Lon: \(trip.origin.longitude, specifier: "%.5f")")
                    }
                    .font(.caption)
                    
                case .end:
                    Text(trip.destinationAddress)
                        .font(.body)
                    VStack(spacing: 8) {
                        Text("Lat: \(trip.destination.latitude, specifier: "%.5f")")
                        Text("Lon: \(trip.destination.longitude, specifier: "%.5f")")
                    }
                    .font(.caption)
                    
                case .stop(let index):
                    let stop = trip.stops[safe: index - 1]
                    if let stop = stop {
                        Text("Lat: \(stop.point.latitude, specifier: "%.5f")")
                        Text("Lon: \(stop.point.longitude, specifier: "%.5f")")
                    } else {
                        Text("Stop not found.")
                    }
                }
                
                Spacer()
            }
            .padding()
            .presentationDetents([.fraction(0.2)])
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
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

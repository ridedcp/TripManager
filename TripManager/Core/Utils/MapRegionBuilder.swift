//
//  MapRegionBuilder.swift
//  TripManager
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation
import MapKit
import CoreLocation

enum MapRegionBuilder {
    static func regionFitting(origin: GeoPoint, destination: GeoPoint, stops: [GeoPoint], paddingFactor: Double = 1.5) -> MKCoordinateRegion {
        let allPoints = [origin, destination] + stops

        let minLat = allPoints.map(\.latitude).min() ?? 0
        let maxLat = allPoints.map(\.latitude).max() ?? 0
        let minLon = allPoints.map(\.longitude).min() ?? 0
        let maxLon = allPoints.map(\.longitude).max() ?? 0

        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )

        let latDelta = (maxLat - minLat) * paddingFactor + 0.01
        let lonDelta = (maxLon - minLon) * paddingFactor + 0.01

        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)

        return MKCoordinateRegion(center: center, span: span)
    }
}


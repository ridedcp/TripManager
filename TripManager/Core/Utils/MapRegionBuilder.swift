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
    static func regionFitting(origin: GeoPoint, destination: GeoPoint, paddingFactor: Double = 1.5) -> MKCoordinateRegion {
        let center = CLLocationCoordinate2D(
            latitude: (origin.latitude + destination.latitude) / 2,
            longitude: (origin.longitude + destination.longitude) / 2
        )

        let latDiff = abs(origin.latitude - destination.latitude)
        let lonDiff = abs(origin.longitude - destination.longitude)

        let latDelta = latDiff * paddingFactor + 0.01
        let lonDelta = lonDiff * paddingFactor + 0.01

        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)

        return MKCoordinateRegion(center: center, span: span)
    }
}


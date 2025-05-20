//
//  GeoPoint.swift
//  TripManager
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation
import MapKit

struct GeoPoint: Equatable {
    let latitude: Double
    let longitude: Double
}

extension GeoPoint {
    func toCoord() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

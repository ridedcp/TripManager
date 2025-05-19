//
//  RouteDecoder.swift
//  TripManager
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation
import CoreLocation
import Polyline

enum RouteDecoder {
    static func decodePolyline(_ polyline: String) -> [CLLocationCoordinate2D] {
        Polyline(encodedPolyline: polyline).coordinates ?? []
    }
}


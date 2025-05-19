//
//  MockGetTripsUseCase.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation
@testable import TripManager

final class MockGetTripsUseCase: GetTripsUseCase {

    enum ResponseType {
        case success
        case failure
    }

    private let responseType: ResponseType

    init(responseType: ResponseType) {
        self.responseType = responseType
    }

    func execute() async throws -> [Trip] {
        switch responseType {
        case .success:
            return [
                Trip(
                    description: "Barcelona → Martorell",
                    driverName: "Alberto",
                    startTime: Date(),
                    endTime: Date().addingTimeInterval(1800),
                    origin: GeoPoint(latitude: 41.38074, longitude: 2.18594),
                    destination: GeoPoint(latitude: 41.49958, longitude: 1.90307),
                    route: "sdq{Fc}iLj@zR|W~TryCzvC"
                ),
                Trip(
                    description: "Sabadell → Terrassa",
                    driverName: "Daniel",
                    startTime: Date(),
                    endTime: Date().addingTimeInterval(3600),
                    origin: GeoPoint(latitude: 41.5463, longitude: 2.1086),
                    destination: GeoPoint(latitude: 41.5632, longitude: 2.0087),
                    route: "mif_GoifP}`F?auAst@qdCxmA"
                )
            ]
        case .failure:
            throw TripServiceError.invalidResponse
        }
    }
}

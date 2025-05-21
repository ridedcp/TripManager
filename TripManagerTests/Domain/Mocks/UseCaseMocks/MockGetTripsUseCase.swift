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
                    id: 0,
                    description: "Barcelona → Martorell",
                    driverName: "Alberto",
                    startTime: Date(),
                    endTime: Date().addingTimeInterval(1800),
                    origin: GeoPoint(latitude: 41.38074, longitude: 2.18594),
                    destination: GeoPoint(latitude: 41.49958, longitude: 1.90307),
                    route: "sdq{Fc}iLj@zR|W~TryCzvC",
                    stops: [
                        Stop(id: 1, point: GeoPoint(latitude: 41.385, longitude: 2.18)),
                        Stop(id: 2, point: GeoPoint(latitude: 41.39, longitude: 2.17))
                    ],
                    originAddress: "some origin",
                    destinationAddress: "some destination"
                ),
                Trip(
                    id: 0,
                    description: "Girona → Banyoles",
                    driverName: "María",
                    startTime: Date(),
                    endTime: Date().addingTimeInterval(3600),
                    origin: GeoPoint(latitude: 41.98055, longitude: 2.82280),
                    destination: GeoPoint(latitude: 42.12741, longitude: 2.76088),
                    route: "mif_GoifP}`F?auAst@qdCxmA",
                    stops: [
                        Stop(id: 3, point: GeoPoint(latitude: 42.07967, longitude: 2.81734)),
                        Stop(id: 4, point: GeoPoint(latitude: 42.10362, longitude: 2.80567))
                    ],
                    originAddress: "some origin",
                    destinationAddress: "some destination"
                )
            ]
        case .failure:
            throw TripServiceError.invalidResponse
        }
    }
}

//Website to get route
//https://developers.google.com/maps/documentation/utilities/polylineutility?hl=es-419

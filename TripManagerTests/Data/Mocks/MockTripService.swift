//
//  MockTripService.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation
@testable import TripManager

final class MockTripService: TripService {
    
    enum ResponseType {
        case success
        case serviceError
        case mapperError
    }
    
    private let responseType: ResponseType

    init(responseType: ResponseType) {
        self.responseType = responseType
    }

    func fetchTrips() async throws -> [TripDTO] {
        switch responseType {
        case .success:
            return [
                TripDTO(
                    description: "Mock trip",
                    driverName: "Mock driver",
                    startTime: "2018-12-18T08:00:00.000Z",
                    endTime: "2018-12-18T09:00:00.000Z",
                    origin: LocationDTO(address: "Origen de prueba", point: PointDTO(latitude: 41.38074, longitude: 2.18594)),
                    destination: LocationDTO(address: "Destino de prueba", point: PointDTO(latitude: 41.39664, longitude: 2.16073)),
                    route: "sdq{Fc}iLj@zR|W~TryCzvC",
                    stops: [
                        StopDTO(id: 1, point: PointDTO(latitude: 41.385, longitude: 2.18)),
                        StopDTO(id: 2, point: PointDTO(latitude: 41.39, longitude: 2.17))
                    ]
                )
            ]

        case .serviceError:
            throw TripServiceError.invalidResponse

        case .mapperError:
            return [
                TripDTO(
                    description: "Broken trip",
                    driverName: "Driver",
                    startTime: "not-a-date",
                    endTime: "2018-12-18T09:00:00.000Z",
                    origin: LocationDTO(address: "Origen con error", point: PointDTO(latitude: 41.0, longitude: 2.0)),
                    destination: LocationDTO(address: "Destino con error", point: PointDTO(latitude: 42.0, longitude: 3.0)),
                    route: "xxx",
                    stops: []
                )
            ]
        }
    }
}

//Website to get route
//https://developers.google.com/maps/documentation/utilities/polylineutility?hl=es-419

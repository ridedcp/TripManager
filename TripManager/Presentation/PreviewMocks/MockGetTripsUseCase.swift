//
//  MockGetTripsUseCase.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

struct MockGetTripsUseCase: GetTripsUseCase {
    func execute() async throws -> [Trip] {
        return [
            Trip(
                description: "Barcelona → Martorell",
                driverName: "Alberto Morales",
                startTime: Date(),
                endTime: Date().addingTimeInterval(3600)
            ),
            Trip(
                description: "Sabadell → Terrassa",
                driverName: "Daniel Cano",
                startTime: Date(),
                endTime: Date().addingTimeInterval(1800)
            )
        ]
    }
}


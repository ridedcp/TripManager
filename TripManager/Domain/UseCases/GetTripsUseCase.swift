//
//  GetTripsUseCase.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

protocol GetTripsUseCase {
    func execute() async throws -> [Trip]
}

//
//  GetDetailedStopsUseCase.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

protocol GetDetailedStopUseCase {
    func execute() async throws -> StopDetailed
}

//
//  MockStopDetailedRepository.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation
@testable import TripManager

final class MockStopDetailedRepository: StopDetailedRepository {
    private let result: Result<[StopDetailed], Error>

    init(result: Result<[StopDetailed], Error>) {
        self.result = result
    }

    func getDetailedStops() async throws -> [StopDetailed] {
        switch result {
        case .success(let stops):
            return stops
        case .failure(let error):
            throw error
        }
    }
}

//
//  MockStopDetailedRepository.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation
@testable import TripManager

final class MockStopDetailedRepository: StopDetailedRepository {
    private let result: Result<[DetailedStop], Error>

    init(result: Result<[DetailedStop], Error>) {
        self.result = result
    }

    func getDetailedStops() async throws -> [DetailedStop] {
        switch result {
        case .success(let stops):
            return stops
        case .failure(let error):
            throw error
        }
    }
}

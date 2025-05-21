//
//  MockDetailedStopRepository.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation
@testable import TripManager

final class MockDetailedStopRepository: DetailedStopRepository {
    private let result: Result<DetailedStop, Error>

    init(result: Result<DetailedStop, Error>) {
        self.result = result
    }

    func getDetailedStop() async throws -> DetailedStop {
        switch result {
        case .success(let stop):
            return stop
        case .failure(let error):
            throw error
        }
    }
}

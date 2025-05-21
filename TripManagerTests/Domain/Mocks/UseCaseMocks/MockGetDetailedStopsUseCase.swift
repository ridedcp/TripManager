//
//  MockGetDetailedStopsUseCase.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 21/5/25.
//

import Foundation
@testable import TripManager

final class MockGetDetailedStopUseCase: GetDetailedStopUseCase {
    private let result: Result<DetailedStop, Error>

    init(result: Result<DetailedStop, Error>) {
        self.result = result
    }

    func execute() async throws -> DetailedStop {
        switch result {
        case .success(let stop):
            return stop
        case .failure(let error):
            throw error
        }
    }
}

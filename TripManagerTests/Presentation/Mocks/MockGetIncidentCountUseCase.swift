//
//  MockGetIncidentCountUseCase.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 21/5/25.
//

import Foundation
@testable import TripManager

final class MockGetIncidentCountUseCase: GetIncidentCountUseCase {
    private let count: Int
    init(count: Int = 1) {
        self.count = count
    }
    func execute() -> Int {
        return count
    }
}



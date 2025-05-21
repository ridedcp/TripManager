//
//  MockSetBadgeCountUseCase.swift
//  TripManager
//
//  Created by Daniel Cano on 21/5/25.
//

import Foundation
@testable import TripManager

final class MockSetBadgeCountUseCase: SetBadgeCountUseCase {
    var lastSetCount: Int?
    func execute(_ count: Int) {
        lastSetCount = count
    }
}

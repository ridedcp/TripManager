//
//  MockSaveIncidentUseCase.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 21/5/25.
//

import Foundation
@testable import TripManager

final class MockSaveIncidentUseCase: SaveIncidentUseCase {
    private(set) var didCallExecute = false
    private(set) var receivedIncident: Incident?

    func execute(_ incident: Incident) {
        didCallExecute = true
        receivedIncident = incident
    }
}

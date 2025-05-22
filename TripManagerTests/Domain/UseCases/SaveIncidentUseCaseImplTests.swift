//
//  SaveIncidentUseCaseImplTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 22/5/25.
//

import XCTest
@testable import TripManager

final class SaveIncidentUseCaseImplTests: XCTestCase {

    func test_execute_addsIncidentToRepository() {
        // Given
        let mockRepository = MockIncidentRepository()
        let useCase = SaveIncidentUseCaseImpl(repository: mockRepository)

        let incident = Incident(
            id: UUID(),
            fullName: "John Smith",
            email: "john@example.com",
            phone: "123456789",
            timestamp: Date(),
            description: "Broken seat"
        )

        // When
        useCase.execute(incident)

        // Then
        XCTAssertEqual(mockRepository.incidents.count, 1)
        XCTAssertEqual(mockRepository.incidents.first, incident)
    }
}

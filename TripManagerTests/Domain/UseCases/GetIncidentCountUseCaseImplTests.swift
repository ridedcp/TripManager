//
//  GetIncidentCountUseCaseImplTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 21/5/25.
//

import XCTest
@testable import TripManager

final class GetIncidentCountUseCaseImplTests: XCTestCase {

    func test_execute_returnsCorrectIncidentCount() {
        // Given
        let mockRepository = MockIncidentRepository()
        mockRepository.incidents = [
            Incident(id: UUID(), fullName: "User 1", email: "user1@example.com", phone: nil, timestamp: Date(), description: "desc 1"),
            Incident(id: UUID(), fullName: "User 2", email: "user2@example.com", phone: nil, timestamp: Date(), description: "desc 2")
        ]
        let useCase = GetIncidentCountUseCaseImpl(repository: mockRepository)

        // When
        let count = useCase.execute()

        // Then
        XCTAssertEqual(count, 2)
    }

    func test_execute_returnsZeroWhenNoIncidentsExist() {
        // Given
        let mockRepository = MockIncidentRepository()
        mockRepository.incidents = []
        let useCase = GetIncidentCountUseCaseImpl(repository: mockRepository)

        // When
        let count = useCase.execute()

        // Then
        XCTAssertEqual(count, 0)
    }
}

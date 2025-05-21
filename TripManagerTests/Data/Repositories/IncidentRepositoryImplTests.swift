//
//  IncidentRepositoryImplTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 21/5/25.
//

import XCTest
@testable import TripManager

final class IncidentRepositoryImplTests: XCTestCase {

    private var repository: IncidentRepositoryImpl!
    private var mockStore: MockIncidentStore!

    override func setUp() {
        super.setUp()
        mockStore = MockIncidentStore()
        repository = IncidentRepositoryImpl(store: mockStore)
    }

    override func tearDown() {
        repository = nil
        mockStore = nil
        super.tearDown()
    }

    func test_save_callsStoreSave() throws {
        // Given
        let incident = Incident(
            id: UUID(),
            fullName: "Jane Doe",
            email: "jane@example.com",
            phone: "123456789",
            timestamp: Date(),
            description: "Lost luggage"
        )

        // When
        try repository.save(incident)

        // Then
        XCTAssertEqual(mockStore.savedIncidents.first, incident)
    }

    func test_getAll_returnsStoredIncidents() throws {
        // Given
        let expectedIncidents = [
            Incident(id: UUID(), fullName: "A", email: "a@a.com", phone: nil, timestamp: Date(), description: "A"),
            Incident(id: UUID(), fullName: "B", email: "b@b.com", phone: nil, timestamp: Date(), description: "B")
        ]
        mockStore.storedIncidents = expectedIncidents

        // When
        let result = try repository.getAll()

        // Then
        XCTAssertEqual(result, expectedIncidents)
    }
}

//
//  IncidentStoreImplTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 21/5/25.
//

import XCTest
@testable import TripManager

final class IncidentStoreImplTests: XCTestCase {
    var store: IncidentStoreImpl!
    let testKey = "reported_incidents"

    override func setUp() {
        super.setUp()
        store = IncidentStoreImpl()
        UserDefaults.standard.removeObject(forKey: testKey)
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: testKey)
        store = nil
        super.tearDown()
    }

    func test_save_and_getAll_persistsIncident() {
        // Given
        let incident = Incident(
            id: UUID(),
            fullName: "Daniel Cano",
            email: "daniel@example.com",
            phone: "600123456",
            timestamp: Date(),
            description: "Test description"
        )

        // When
        store.save(incident)
        let incidents = store.getAll()

        // Then
        XCTAssertEqual(incidents.count, 1)
        XCTAssertEqual(incidents[0].fullName, "Daniel Cano")
        XCTAssertEqual(incidents[0].email, "daniel@example.com")
    }

    func test_getAll_returnsEmptyArray_whenNoDataStored() {
        // When
        let incidents = store.getAll()

        // Then
        XCTAssertTrue(incidents.isEmpty)
    }

    func test_save_multipleIncidents_accumulatesData() {
        // Given
        let incident1 = Incident(
            id: UUID(),
            fullName: "User 1",
            email: "user1@example.com",
            phone: nil,
            timestamp: Date(),
            description: "Desc 1"
        )

        let incident2 = Incident(
            id: UUID(),
            fullName: "User 2",
            email: "user2@example.com",
            phone: "600000000",
            timestamp: Date(),
            description: "Desc 2"
        )

        // When
        store.save(incident1)
        store.save(incident2)
        let incidents = store.getAll()

        // Then
        XCTAssertEqual(incidents.count, 2)
        XCTAssertEqual(incidents[1].fullName, "User 2")
    }
}

//
//  IncidentStoreImplTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 21/5/25.
//

import XCTest
@testable import TripManager

final class IncidentStoreImplTests: XCTestCase {

    private var store: IncidentStoreImpl!
    private let testKey = "reported_incidents"

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

    func test_getAll_returnsEmptyArray_whenNoDataStored() {
        let incidents = store.getAll()
        XCTAssertEqual(incidents.count, 0)
    }

    func test_save_and_getAll_persistsIncident() {
        let incident = Incident(
            id: UUID(),
            fullName: "Test User",
            email: "test@example.com",
            phone: "123456789",
            timestamp: Date(),
            description: "Test description"
        )

        store.save(incident)
        let incidents = store.getAll()

        XCTAssertEqual(incidents.count, 1)
        XCTAssertEqual(incidents.first?.fullName, "Test User")
        XCTAssertEqual(incidents.first?.email, "test@example.com")
    }

    func test_save_appendsMultipleIncidents() {
        let incident1 = Incident(id: UUID(), fullName: "A", email: "a@a.com", phone: nil, timestamp: Date(), description: "1")
        let incident2 = Incident(id: UUID(), fullName: "B", email: "b@b.com", phone: nil, timestamp: Date(), description: "2")

        store.save(incident1)
        store.save(incident2)

        let incidents = store.getAll()
        XCTAssertEqual(incidents.count, 2)
    }
}

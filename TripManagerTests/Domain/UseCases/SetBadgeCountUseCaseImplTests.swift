//
//  SetBadgeCountUseCaseImplTests.swift
//  TripManager
//
//  Created by Daniel Cano on 21/5/25.
//

import XCTest
import UserNotifications
@testable import TripManager

final class SetBadgeCountUseCaseImplTests: XCTestCase {

    override func setUp() {
        super.setUp()
        let expectation = expectation(description: "Reset badge")
        UNUserNotificationCenter.current().setBadgeCount(0) { _ in expectation.fulfill() }
        wait(for: [expectation], timeout: 1.0)
    }

    override func tearDown() {
        let expectation = expectation(description: "Reset badge")
        UNUserNotificationCenter.current().setBadgeCount(0) { _ in expectation.fulfill() }
        wait(for: [expectation], timeout: 1.0)
        super.tearDown()
    }

    func test_execute_setsBadgeCountCorrectly() {
        // Given
        let sut = SetBadgeCountUseCaseImpl()
        let expectedCount = 3

        // When
        let expectation = expectation(description: "Badge set")
        UNUserNotificationCenter.current().setBadgeCount(expectedCount) { _ in expectation.fulfill() }
        sut.execute(expectedCount)

        // Then
        wait(for: [expectation], timeout: 1.0)
    }
}

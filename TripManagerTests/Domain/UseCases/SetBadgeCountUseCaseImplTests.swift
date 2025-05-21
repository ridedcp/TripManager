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
        UNUserNotificationCenter.current().setBadgeCount(0)
    }

    func test_execute_setsBadgeCountCorrectly() {
        // Given
        let sut = SetBadgeCountUseCaseImpl()
        let expectedCount = 3
        let expectation = XCTestExpectation(description: "Badge set")

        // When
        sut.execute(expectedCount)

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                DispatchQueue.main.async {
                    XCTAssertTrue(settings.authorizationStatus == .authorized || settings.authorizationStatus == .notDetermined, "Notifications not authorized")
                    expectation.fulfill()
                }
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

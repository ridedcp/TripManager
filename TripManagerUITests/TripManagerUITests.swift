//
//  TripManagerUITests.swift
//  TripManagerUITests
//
//  Created by Daniel Cano on 16/5/25.
//

import XCTest

final class TripManagerUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func test_tripList_displaysTripsAndOpensMap() {
        let firstTrip = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstTrip.waitForExistence(timeout: 5))
        firstTrip.tap()

        let map = app.maps.element
        XCTAssertTrue(map.waitForExistence(timeout: 5))
    }

    func test_tripList_showsContactForm_whenTappingButton() {
        let contactButton = app.buttons["contactFormButton"]
        XCTAssertTrue(contactButton.waitForExistence(timeout: 5))
        contactButton.tap()

        let navTitle = app.navigationBars["Contact Form"]
        XCTAssertTrue(navTitle.waitForExistence(timeout: 5))
    }
    
    func test_contactForm_validatesAndSavesReport() {
        let contactButton = app.buttons["contactFormButton"]
        contactButton.tap()

        let fullNameField = app.textFields["Full Name"]
        fullNameField.tap()
        fullNameField.typeText("Test User")

        let emailField = app.textFields["Email"]
        emailField.tap()
        sleep(1)
        XCTAssertTrue(app.keyboards.element.waitForExistence(timeout: 2))
        emailField.typeText("test@example.com")

        let phoneField = app.textFields["Phone (optional)"]
        phoneField.tap()
        phoneField.typeText("123456789")

        let description = app.textViews.element
        description.tap()
        description.typeText("Everything is working fine")

        let submitButton = app.buttons["Submit"]
        submitButton.tap()

        let savedAlert = app.alerts["Saved"]
        XCTAssertTrue(savedAlert.waitForExistence(timeout: 5))
    }
}

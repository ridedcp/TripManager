//
//  ContactFormViewModelTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 21/5/25.
//

import XCTest
@testable import TripManager

@MainActor
final class ContactFormViewModelTests: XCTestCase {

    private var viewModel: ContactFormViewModel!
    private var mockSaveIncidentUseCase: MockSaveIncidentUseCase!

    override func setUp() {
        super.setUp()
        mockSaveIncidentUseCase = MockSaveIncidentUseCase()
        viewModel = ContactFormViewModel(saveIncidentUseCase: mockSaveIncidentUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockSaveIncidentUseCase = nil
        super.tearDown()
    }

    func test_submit_showsError_whenFullNameIsEmpty() {
        viewModel.fullName = ""
        viewModel.email = "test@example.com"
        viewModel.phone = "123456789"
        viewModel.descriptionText = "Valid description"

        viewModel.submit()

        XCTAssertTrue(viewModel.showError)
        XCTAssertEqual(viewModel.errorMessage, "Some fields are invalid.")
        XCTAssertFalse(viewModel.didSave)
    }

    func test_submit_showsError_whenEmailIsInvalid() {
        viewModel.fullName = "John Doe"
        viewModel.email = "invalidEmail"
        viewModel.phone = "123456789"
        viewModel.descriptionText = "Valid description"

        viewModel.submit()

        XCTAssertTrue(viewModel.showError)
        XCTAssertEqual(viewModel.errorMessage, "Some fields are invalid.")
        XCTAssertFalse(viewModel.didSave)
    }

    func test_submit_showsError_whenPhoneIsInvalid() {
        viewModel.fullName = "John Doe"
        viewModel.email = "test@example.com"
        viewModel.phone = "123abc789"
        viewModel.descriptionText = "Valid description"

        viewModel.submit()

        XCTAssertTrue(viewModel.showError)
        XCTAssertEqual(viewModel.errorMessage, "Some fields are invalid.")
        XCTAssertFalse(viewModel.didSave)
    }

    func test_submit_showsError_whenDescriptionTooShort() {
        viewModel.fullName = "John Doe"
        viewModel.email = "test@example.com"
        viewModel.phone = "123456789"
        viewModel.descriptionText = "Hi"

        viewModel.submit()

        XCTAssertTrue(viewModel.showError)
        XCTAssertEqual(viewModel.errorMessage, "Some fields are invalid.")
        XCTAssertFalse(viewModel.didSave)
    }

    func test_submit_showsError_whenDescriptionTooLong() {
        viewModel.fullName = "John Doe"
        viewModel.email = "test@example.com"
        viewModel.phone = "123456789"
        viewModel.descriptionText = String(repeating: "a", count: 201)

        viewModel.submit()

        XCTAssertTrue(viewModel.showError)
        XCTAssertEqual(viewModel.errorMessage, "Some fields are invalid.")
        XCTAssertFalse(viewModel.didSave)
    }

    func test_submit_succeeds_withValidData() {
        viewModel.fullName = "John Doe"
        viewModel.email = "test@example.com"
        viewModel.phone = "123456789"
        viewModel.descriptionText = "Everything is working fine"

        viewModel.submit()

        XCTAssertFalse(viewModel.showError)
        XCTAssertTrue(viewModel.didSave)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertTrue(mockSaveIncidentUseCase.didCallExecute)
        XCTAssertNotNil(mockSaveIncidentUseCase.receivedIncident)
    }

    func test_phoneValidation_acceptsEmptyPhone() {
        viewModel.phone = ""
        XCTAssertTrue(viewModel.isPhoneValid)
    }

    func test_phoneValidation_rejectsShortPhone() {
        viewModel.phone = "123"
        XCTAssertFalse(viewModel.isPhoneValid)
    }

    func test_phoneValidation_rejectsNonNumericPhone() {
        viewModel.phone = "12abc5679"
        XCTAssertFalse(viewModel.isPhoneValid)
    }

    func test_phoneValidation_acceptsNineDigitPhone() {
        viewModel.phone = "123456789"
        XCTAssertTrue(viewModel.isPhoneValid)
    }
}

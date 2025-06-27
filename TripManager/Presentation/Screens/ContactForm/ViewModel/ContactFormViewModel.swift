//
//  ContactFormViewModel.swift
//  TripManager
//
//  Created by Daniel Cano on 21/5/25.
//

import Foundation
import Combine

@MainActor
final class ContactFormViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var descriptionText: String = ""

    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var didSave: Bool = false

    var isFullNameValid: Bool {
        !fullName.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var isEmailValid: Bool {
        email.contains("@") && email.split(separator: "@").count == 2 && email.split(separator: "@")[1].contains(".")
    }

    var isPhoneValid: Bool {
        phone.isEmpty || (phone.count == 9 && phone.allSatisfy(\.isNumber))
    }

    var isDescriptionValid: Bool {
        descriptionText.count >= 3 && descriptionText.count <= 200
    }

    var isFormValid: Bool {
        isFullNameValid && isEmailValid && isPhoneValid && isDescriptionValid
    }
    
    private let saveIncidentUseCase: SaveIncidentUseCase

    init(saveIncidentUseCase: SaveIncidentUseCase) {
        self.saveIncidentUseCase = saveIncidentUseCase
    }

    func submit() {
        guard isFormValid else {
            showValidationError("Some fields are invalid.")
            return
        }

        let incident = Incident(
            id: UUID(),
            fullName: fullName,
            email: email,
            phone: phone.isEmpty ? nil : phone,
            timestamp: Date(),
            description: descriptionText
        )

        saveIncidentUseCase.execute(incident)
        didSave = true
    }

    private func showValidationError(_ message: String) {
        errorMessage = message
        showError = true
    }
}

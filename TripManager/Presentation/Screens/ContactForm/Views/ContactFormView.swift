//
//  ContactFormView.swift
//  TripManager
//
//  Created by Daniel Cano on 21/5/25.
//

import SwiftUI

struct ContactFormView: View {
    @StateObject var viewModel: ContactFormViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Details")) {
                    TextField("Full Name", text: $viewModel.fullName)
                        .overlay(validationMark(viewModel.isFullNameValid), alignment: .trailing)

                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .overlay(validationMark(viewModel.isEmailValid), alignment: .trailing)

                    TextField("Phone (optional)", text: $viewModel.phone)
                        .keyboardType(.numberPad)
                        .overlay(validationMark(viewModel.isPhoneValid), alignment: .trailing)
                }

                Section(header: Text("Report")) {
                    TextEditor(text: $viewModel.descriptionText)
                        .frame(height: 100)
                        .overlay(
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text("\(viewModel.descriptionText.count)/200")
                                        .font(.caption)
                                        .foregroundColor(viewModel.isDescriptionValid ? .gray : .red)
                                }
                            }
                            .padding(.horizontal, 4)
                        )
                }

                Button("Submit") {
                    viewModel.submit()
                }
                .disabled(!viewModel.isFormValid)
            }
            .navigationTitle("Contact Form")
            .alert("Error", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage)
            }
            .alert("Saved", isPresented: $viewModel.didSave) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Your report was saved.")
            }
        }
    }

    private func validationMark(_ isValid: Bool) -> some View {
        Image(systemName: isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
            .foregroundColor(isValid ? .green : .red)
            .padding(.trailing, 8)
    }
}

#Preview {
    ContactFormView(
        viewModel: ContactFormViewModel(
            saveIncidentUseCase: SaveIncidentUseCaseImpl(repository: IncidentRepositoryImpl(store: IncidentStoreImpl())
            )
        )
    )
}

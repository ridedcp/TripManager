//
//  TripManagerApp.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import SwiftUI

@main
struct TripManagerApp: App {
    var body: some Scene {
        WindowGroup {
            TripListView(
                viewModel: TripListViewModel(
                    getTripsUseCase: GetTripsUseCaseImpl(
                        repository: TripRepositoryImpl(
                            service: TripServiceImpl()
                        )
                    )
                )
            )
        }
    }
}

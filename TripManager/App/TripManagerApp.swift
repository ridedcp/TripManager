//
//  TripManagerApp.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import SwiftUI

@main
struct TripManagerApp: App {
    private let diContainer = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            TripListView(viewModel: diContainer.makeTripListViewModel(), diContainer: diContainer)
        }
    }
}

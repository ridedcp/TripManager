//
//  AppDIContainer.swift
//  TripManager
//
//  Created by Daniel Cano on 21/5/25.
//

import Foundation

@MainActor
final class AppDIContainer {
    
    // MARK: - UseCases
    
    func makeTripListViewModel() -> TripListViewModel {
        TripListViewModel(
            getTripsUseCase: makeGetTripsUseCase(),
            getIncidentCountUseCase: makeGetIncidentCountUseCase(),
            setBadgeCountUseCase: SetBadgeCountUseCaseImpl()
        )
    }

    func makeContactFormViewModel() -> ContactFormViewModel {
        ContactFormViewModel(
            saveIncidentUseCase: makeSaveIncidentUseCase()
        )
    }

    func makeTripMapViewModel() -> TripMapViewModel {
        TripMapViewModel(getDetailedStopUseCase: makeGetDetailedStopUseCase())
    }

    // MARK: - UseCase Builders

    private func makeGetTripsUseCase() -> GetTripsUseCase {
        GetTripsUseCaseImpl(repository: makeTripRepository())
    }

    private func makeSaveIncidentUseCase() -> SaveIncidentUseCase {
        SaveIncidentUseCaseImpl(repository: makeIncidentRepository())
    }

    private func makeGetIncidentCountUseCase() -> GetIncidentCountUseCase {
        GetIncidentCountUseCaseImpl(repository: makeIncidentRepository())
    }

    private func makeGetDetailedStopUseCase() -> GetDetailedStopUseCase {
        GetDetailedStopUseCaseImpl(repository: makeDetailedStopRepository())
    }

    // MARK: - Repository Builders

    private func makeTripRepository() -> TripRepository {
        TripRepositoryImpl(service: TripServiceImpl())
    }

    private func makeIncidentRepository() -> IncidentRepository {
        IncidentRepositoryImpl(store: IncidentStoreImpl())
    }

    private func makeDetailedStopRepository() -> DetailedStopRepository {
        DetailedStopRepositoryImpl(service: DetailedStopServiceImpl())
    }
}

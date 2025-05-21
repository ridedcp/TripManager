//
//  TripMapViewModel.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation
import MapKit

@MainActor
final class TripMapViewModel: ObservableObject {
    @Published var detailedStop: DetailedStop?
    @Published var selectedStopIndex: Int?
    @Published var routeCoordinates: [CLLocationCoordinate2D] = []

    private let getDetailedStopUseCase: GetDetailedStopUseCase

    init(getDetailedStopUseCase: GetDetailedStopUseCase) {
        self.getDetailedStopUseCase = getDetailedStopUseCase
    }

    func loadDetailedStop() async {
        do {
            detailedStop = try await getDetailedStopUseCase.execute()
        } catch {
            detailedStop = nil
        }
    }

    func decodePolyline(_ route: String) {
        routeCoordinates = RouteDecoder.decodePolyline(route)
    }
}


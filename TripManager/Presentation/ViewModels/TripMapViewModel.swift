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
    @Published var detailedStops: [StopDetailed] = []
    @Published var selectedStop: StopDetailed?
    @Published var routeCoordinates: [CLLocationCoordinate2D] = []

    private let getDetailedStopsUseCase: GetDetailedStopsUseCase

    init(getDetailedStopsUseCase: GetDetailedStopsUseCase) {
        self.getDetailedStopsUseCase = getDetailedStopsUseCase
    }

    func loadDetailedStops(for tripId: Int) async {
        do {
            let allStops = try await getDetailedStopsUseCase.execute()
            detailedStops = allStops.filter { $0.tripId == tripId }
        } catch {
            detailedStops = []
        }
    }
    
    func decodePolyline(_ route: String) {
        routeCoordinates = RouteDecoder.decodePolyline(route)
    }
}


//
//  StopDetailedService.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

protocol StopDetailedService {
    func fetchDetailedStops() async throws -> [StopDetailedDTO]
}

final class StopDetailedServiceImpl: StopDetailedService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchDetailedStops() async throws -> [StopDetailedDTO] {
        let urlString = "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/stops.json"
        guard let url = URL(string: urlString) else {
            throw TripServiceError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw TripServiceError.invalidResponse
        }

        return try JSONDecoder().decode([StopDetailedDTO].self, from: data)
    }
}

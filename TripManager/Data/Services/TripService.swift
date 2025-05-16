//
//  TripService.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

protocol TripService {
    func fetchTrips() async throws -> [TripDTO]
}

final class TripServiceImpl: TripService {
    func fetchTrips() async throws -> [TripDTO] {
        let urlString = "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/trips.json"
        guard let url = URL(string: urlString) else {
            throw TripServiceError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw TripServiceError.invalidResponse
            }

            return try JSONDecoder().decode([TripDTO].self, from: data)
        } catch let decodingError as DecodingError {
            throw TripServiceError.decodingError
        } catch {
            throw TripServiceError.networkError(error)
        }
    }
}

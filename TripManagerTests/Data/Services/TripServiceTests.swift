//
//  TripServiceTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import XCTest
@testable import TripManager

final class TripServiceTests: XCTestCase {

    func test_fetchTrips_returnsMockedDTOs() async throws {
        // Given
        let mockJSON = """
        [
            {
                "description": "Test Trip",
                "driverName": "Driver One",
                "startTime": "2018-12-18T08:00:00.000Z",
                "endTime": "2018-12-18T09:00:00.000Z",
                "origin": {
                    "address": "Origen",
                    "point": {
                        "_latitude": 41.38074,
                        "_longitude": 2.18594
                    }
                },
                "destination": {
                    "address": "Destino",
                    "point": {
                        "_latitude": 41.39664,
                        "_longitude": 2.16073
                    }
                },
                "route": "sdq{Fc}iLj@zR|W~TryCzvC"
            }
        ]
        """.data(using: .utf8)!

        MockURLProtocol.mockResponseData = mockJSON

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        let service = TripServiceImpl(session: session)

        // When
        let trips = try await service.fetchTrips()

        // Then
        XCTAssertEqual(trips.count, 1)
        XCTAssertEqual(trips[0].description, "Test Trip")
    }
    
    func test_fetchTrips_throwsDecodingError_whenJSONIsInvalid() async {
        // Given
        let invalidJSON = """
        [
            {
                "description": "Invalid Trip",
                "driver": "WrongKey",
                "startTime": "2018-12-18T08:00:00.000Z",
                "endTime": "2018-12-18T09:00:00.000Z"
            }
        ]
        """.data(using: .utf8)!

        MockURLProtocol.mockResponseData = invalidJSON

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        let service = TripServiceImpl(session: session)

        // When / Then
        do {
            _ = try await service.fetchTrips()
            XCTFail("Expected to throw decoding error")
        } catch {
            print("error: \(error)")
        }
    }
    
    func test_fetchTrips_throwsInvalidResponse_whenStatusCodeIsNot2xx() async {
        // Given
        MockURLProtocol.mockResponseData = "{}".data(using: .utf8)
        MockURLProtocol.responseStatusCode = 500

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        let service = TripServiceImpl(session: session)

        // When / Then
        do {
            _ = try await service.fetchTrips()
            XCTFail("Expected to throw decoding error")
        } catch {
            print("error: \(error)")
        }

        // Reset
        MockURLProtocol.responseStatusCode = 200
    }
    
    func test_fetchTrips_throwsNetworkError_whenSessionFails() async {
        // Given
        MockURLProtocol.error = URLError(.notConnectedToInternet)

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        let service = TripServiceImpl(session: session)

        // When / Then
        do {
            _ = try await service.fetchTrips()
            XCTFail("Expected to throw network error")
        } catch let error as TripServiceError {
            switch error {
            case .networkError(let underlying):
                XCTAssertTrue(underlying is URLError)
            default:
                XCTFail("Expected networkError but got \(error)")
            }
        } catch {
            XCTFail("Expected TripServiceError but got \(error)")
        }

        // Reset
        MockURLProtocol.error = nil
    }
}


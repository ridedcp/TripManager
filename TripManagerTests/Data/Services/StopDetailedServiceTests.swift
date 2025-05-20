//
//  StopDetailedServiceTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

import XCTest
@testable import TripManager

final class StopDetailedServiceTests: XCTestCase {

    func test_fetchDetailedStops_returnsDecodedDTOs() async throws {
        // Given
        let json = """
        [
            {
                "id": 1,
                "point": { "_latitude": 41.37653, "_longitude": 2.17924 },
                "address": "Ramblas, Barcelona",
                "tripId": 1,
                "paid": true,
                "stopTime": "2018-12-18T08:10:00.000Z",
                "userName": "Manuel Gomez",
                "price": 1.5
            }
        ]
        """.data(using: .utf8)!

        MockURLProtocol.mockResponseData = json
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        let service = StopDetailedServiceImpl(session: session)

        // When
        let result = try await service.fetchDetailedStops()

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].id, 1)
        XCTAssertEqual(result[0].userName, "Manuel Gomez")
    }

    func test_fetchDetailedStops_throwsOnInvalidJSON() async {
        // Given
        let invalidJSON = "{ bad json ]".data(using: .utf8)!
        MockURLProtocol.mockResponseData = invalidJSON

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let service = StopDetailedServiceImpl(session: session)

        // When / Then
        do {
            _ = try await service.fetchDetailedStops()
            XCTFail("Expected error was not thrown")
        } catch {
            XCTAssertTrue(error is DecodingError || error is TripServiceError)
        }
    }

    func test_fetchDetailedStops_throwsOnBadStatusCode() async {
        // Given
        let validJSON = "[]".data(using: .utf8)!
        MockURLProtocol.mockResponseData = validJSON
        MockURLProtocol.responseStatusCode = 500

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        let service = StopDetailedServiceImpl(session: session)

        // When / Then
        do {
            _ = try await service.fetchDetailedStops()
            XCTFail("Expected error was not thrown")
        } catch let error as TripServiceError {
            switch error {
            case .invalidResponse:
                XCTAssertTrue(true)
            default:
                XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}


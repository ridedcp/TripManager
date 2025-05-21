//
//  DetailedStopServiceTests.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 20/5/25.
//

import XCTest
@testable import TripManager

final class DetailedStopServiceTests: XCTestCase {

    func test_fetchDetailedStop_returnsDecodedDTO() async throws {
        // Given
        let json = """
        {
            "price": 1.5,
            "address": "Ramblas, Barcelona",
            "tripId": 1,
            "paid": true,
            "stopTime": "2018-12-18T08:10:00.000Z",
            "point": { "_latitude": 41.37653, "_longitude": 2.17924 },
            "userName": "Manuel Gomez"
        }
        """.data(using: .utf8)!

        MockURLProtocol.mockResponseData = json
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        let service = DetailedStopServiceImpl(session: session)

        // When
        let result = try await service.fetchDetailedStop()

        // Then
        XCTAssertEqual(result.userName, "Manuel Gomez")
        XCTAssertEqual(result.tripId, 1)
        XCTAssertEqual(result.price, 1.5)
    }

    func test_fetchDetailedStop_throwsOnInvalidJSON() async {
        // Given
        let invalidJSON = "{ bad json ]".data(using: .utf8)!
        MockURLProtocol.mockResponseData = invalidJSON

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let service = DetailedStopServiceImpl(session: session)

        // When / Then
        do {
            _ = try await service.fetchDetailedStop()
            XCTFail("Expected error was not thrown")
        } catch {
            XCTAssertTrue(error is DecodingError || error is TripServiceError)
        }
    }

    func test_fetchDetailedStop_throwsOnBadStatusCode() async {
        // Given
        let validJSON = "{}".data(using: .utf8)!
        MockURLProtocol.mockResponseData = validJSON
        MockURLProtocol.responseStatusCode = 500

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        let service = DetailedStopServiceImpl(session: session)

        // When / Then
        do {
            _ = try await service.fetchDetailedStop()
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

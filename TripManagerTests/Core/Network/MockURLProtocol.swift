//
//  MockURLProtocol.swift
//  TripManagerTests
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    static var mockResponseData: Data?
    static var responseStatusCode: Int = 200

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        if let data = Self.mockResponseData {
            self.client?.urlProtocol(self, didLoad: data)
        }

        let response = HTTPURLResponse(url: request.url!, statusCode: Self.responseStatusCode, httpVersion: nil, headerFields: nil)!

        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}


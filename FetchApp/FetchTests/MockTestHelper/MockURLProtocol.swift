//
//  MockURLProtocol.swift
//  FetchTests
//
//  Created by Ankur Chauhan on 9/16/24.
//
//https://developer.apple.com/documentation/foundation/urlprotocol

import Foundation

class MockURLProtocol: URLProtocol {
    
    // Simulated data and error
    static var mockData: Data?
    static var mockError: Error?
    
    // This method determines whether this protocol can handle the given request, will return true to handle all request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    // Return the same request since we aren't modifying the request
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    // Start loading the request
    override func startLoading() {
        if let mockError = MockURLProtocol.mockError {
            self.client?.urlProtocol(self, didFailWithError: mockError)
        } else if let mockData = MockURLProtocol.mockData {
            self.client?.urlProtocol(self, didLoad: mockData)
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }

    // Stop loading the request
    override func stopLoading() {
        // No operation needed
    }
}

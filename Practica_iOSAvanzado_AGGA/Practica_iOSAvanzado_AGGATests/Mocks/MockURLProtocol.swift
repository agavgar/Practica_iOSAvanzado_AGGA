//
//  MockURLProtocol.swift
//  Practica_IOSAvanzado_AGGATests
//
//  Created by Alejandro Alberto Gavira García on 25/2/24.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var error: Error?
    static var handler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        
        guard let handler = MockURLProtocol.handler else {
            fatalError("Handler not provided")
        }
        
        do{
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }catch{
            client?.urlProtocol(self, didFailWithError: error)
        }
        
    }
    
    static func urlResponseFor(url: URL, statusCode: Int = 200) -> HTTPURLResponse? {
        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: ["Content-Type" : "applicatioon/json"])
    }
    
}

//
//  APiProviderTests.swift
//  Practica_IOSAvanzado_AGGATests
//
//  Created by Alejandro Alberto Gavira García on 25/2/24.
//

import XCTest
@testable import Practica_IOSAvanzado_AGGA
final class APiProviderTests: XCTestCase {
    
    var sut: ApiProvider!
    let token = "expectedToken"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        //sut = ApiProvider(secureData: "Añadir Algo")
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func test_Login(){
        // Given
        MockURLProtocol.handler = { request in
            XCTAssert(request.httpMethod, "GET")
            let url = try XCTUnwrap(request.url)
            
            return (HTTPURLResponse(), Data())
        }
        //When
        
        //Then
    }
    
}

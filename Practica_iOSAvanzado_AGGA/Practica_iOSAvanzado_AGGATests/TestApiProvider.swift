//
//  APiProviderTests.swift
//  Practica_IOSAvanzado_AGGATests
//
//  Created by Alejandro Alberto Gavira García on 25/2/24.
//

import XCTest
@testable import Practica_IOSAvanzado_AGGA
final class TestApiProvider: XCTestCase {
    
    var sut: ApiProvider!
    var mockSecureData: MockSecureData!
    
    let fakeGoku = [DBHeroes(
        name: "Goku",
        id: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94",
        favorite: false,
        description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
        photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300"
    )]
    let fakeTransform = [DBTransformations(
        id: "AF82F83D-9D93-451B-97FE-0962C6A6B011",
        name: "10. Super Saiyan 3",
        description: "400 veces aumenta el poder de Goku desde su estado base. El Super Saiyan nivel 3 se caracteriza por el pelo largo y la pérdida de las cejas, amén del extraordinario poder que se alcanza permitiendo a Goku luchar de tú a tú contra Majin Bu. El principal problema de este nivel es que estando vivo Goku es incapaz de sostenerlo mucho tiempo, es más cuando se enfrenta a Kid Bu pasados unos segundos tiene que volver a su estado base porque su cuerpo no le permite mantener tal cantidad de energía. Ya que Goku alcanzó este nivel estando en el Más Allá no se percató del gasto de energía que conllevaría en caso de volver a la vida. El Super Saiyan nivel 3 es el máximo poder que alcanza Goku en Dragon Ball Z.",
        photo: "https://areajugones.sport.es/wp-content/uploads/2017/05/SSJ3.png",
        hero: nil
    )]
    let fakeLocation = [DBLocalization(
        id: "B93A51C8-C92C-44AE-B1D1-9AFE9BA0BCCC",
        latitud: "35.71867899343361",
        longitud: "139.8202084625344",
        hero: nil
                                           )]
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockSecureData = MockSecureData()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        sut = ApiProvider(secureData: mockSecureData as! SecureDataProtocol)
        
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testLoginSucces(){
        //Given
        let expectedToken = "token"
        let loginURL = URL(string: "\(EndPoints.url.rawValue)\(EndPoints.login.rawValue)")
        
        MockURLProtocol.handler = { request in
            guard let url = request.url, url == loginURL else {
                throw NetworkErrors.malformedURL
            }
            
            let response = MockURLProtocol.urlResponseFor(url: url)!
            let data = expectedToken.data(using: .utf8)!
            return (response,data)
        }
        
        let loginExpectation = expectation(description: "Login SUCCES")
        
        //When
        sut.login(user: "testUser", pass: "testPass") { result in
            switch result {
            case .success(let token):
                print("\(token)")
                XCTAssertEqual(token, expectedToken, "Token not match")
                XCTAssertEqual(self.mockSecureData.getToken(), expectedToken, "Token not saved")
            case .failure(_):
                XCTFail("Failed Login")
            }
        }
        
        //then
        wait(for: [loginExpectation], timeout: 1.0)
    }
    
    func testGetHeroesSuccess() {
        // Given
        let fakeHero = fakeGoku
        let fakeResponseData = try! JSONEncoder().encode(fakeHero)
        MockURLProtocol.handler = { request in
            let response = MockURLProtocol.urlResponseFor(url: request.url!, statusCode: 200)!
            return (response, fakeResponseData)
        }
        
        let expectation = self.expectation(description: "Heroes SUCCES")
        let mockSecureData = MockSecureData()
        mockSecureData.setToken(token: "token")
        let sut = ApiProvider(secureData: mockSecureData as! SecureDataProtocol)
        
        // When
        sut.getHeroes { result in
            // Assert
            switch result {
            case .success(let heroes):
                XCTAssertEqual(heroes, fakeHero)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetTransformSuccess() {
        // Given
        let fakeTransformation = fakeTransform
        let responseData = try! JSONEncoder().encode(fakeTransformation)
        MockURLProtocol.handler = { request in
            let response = MockURLProtocol.urlResponseFor(url: request.url!, statusCode: 200)!
            return (response, responseData)
        }
        
        let expectation = self.expectation(description: "Transform SUCCESS")
        let mockSecureData = MockSecureData()
        mockSecureData.setToken(token: "token")
        let sut = ApiProvider(secureData: mockSecureData as! SecureDataProtocol)
        
        // When
        sut.getTransform(idHeroe: fakeTransformation.first!.id!) { result in
            // Assert
            switch result {
            case .success(let transform):
                XCTAssertEqual(transform, fakeTransformation)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetLocationSuccess() {
        // Given
        let fakeLocation = fakeLocation
        let responseData = try! JSONEncoder().encode(fakeLocation)
        MockURLProtocol.handler = { request in
            let response = MockURLProtocol.urlResponseFor(url: request.url!, statusCode: 200)!
            return (response, responseData)
        }
        
        let expectation = self.expectation(description: "Transform SUCCESS")
        let mockSecureData = MockSecureData()
        mockSecureData.setToken(token: "token")
        let sut = ApiProvider(secureData: mockSecureData)
        
        // When
        sut.getLocalization(idHeroe: fakeLocation.first!.id!) { result in
            // Assert
            switch result {
            case .success(let transform):
                XCTAssertEqual(transform, fakeLocation)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
    }
    
}

//
//  TestStoreDataProvider.swift
//  Practica_IOSAvanzado_AGGATests
//
//  Created by Alejandro Alberto Gavira García on 28/2/24.
//

import XCTest
@testable import Practica_IOSAvanzado_AGGA

final class TestStoreDataProvider: XCTestCase {
    
    var storeDataProvider: StoreDataProvider!
    
    let fakeGoku = [DBHeroes(name: "Goku",
                             id: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94",
                             favorite: false,
                             description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
                             photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300"
                            )]
    
    override func setUpWithError() throws {
        super.setUp()
        storeDataProvider = StoreDataProvider(storeType: .inMemory)
    }
    
    override func tearDownWithError() throws {
        storeDataProvider.removeDDBB()
        storeDataProvider = nil
        super.tearDown()
    }
    
    func testInitStoreDataProvider_InMemory() {
        let inMemoryProvider = StoreDataProvider(storeType: .inMemory)
        XCTAssertNotNil(inMemoryProvider, "In memory not nil")
    }
    
    func testInitStoreDataProvider_Disk() {
        let diskProvider = StoreDataProvider(storeType: .disk)
        XCTAssertNotNil(diskProvider,"Disk not nil")
    }
    
    func testInsertAndFetchHeroes_Success() {
        let fakeHeroes = fakeGoku
        storeDataProvider.insert(heroes: fakeHeroes)
        let fetchedHeroes = storeDataProvider.fetchHeroes()
        XCTAssertFalse(fetchedHeroes.isEmpty, "Fetch Hero not empty")
        XCTAssertEqual(fetchedHeroes.first?.name, "Goku")
        }
        
        func testInsertAndFetchTransformations_Success() {
            let fakeTransformations = [DBTransformations(
                id: "AF82F83D-9D93-451B-97FE-0962C6A6B011",
                name: "10. Super Saiyan 3",
                description: "400 veces aumenta el poder de Goku desde su estado base. El Super Saiyan nivel 3 se caracteriza por el pelo largo y la pérdida de las cejas, amén del extraordinario poder que se alcanza permitiendo a Goku luchar de tú a tú contra Majin Bu. El principal problema de este nivel es que estando vivo Goku es incapaz de sostenerlo mucho tiempo, es más cuando se enfrenta a Kid Bu pasados unos segundos tiene que volver a su estado base porque su cuerpo no le permite mantener tal cantidad de energía. Ya que Goku alcanzó este nivel estando en el Más Allá no se percató del gasto de energía que conllevaría en caso de volver a la vida. El Super Saiyan nivel 3 es el máximo poder que alcanza Goku en Dragon Ball Z.",
                photo: "https://areajugones.sport.es/wp-content/uploads/2017/05/SSJ3.png",
                hero: fakeGoku.first
            )]
            storeDataProvider.insert(transform: fakeTransformations)
            
            let fetchedTransforms = storeDataProvider.fetchTransform()
            XCTAssertFalse(fetchedTransforms.isEmpty, "Fetching transformations not empty")
            XCTAssertEqual(fetchedTransforms.first?.heroe?.name, "Goku")
            XCTAssertEqual(fetchedTransforms.first?.name, "10. Super Saiyan 3")
        }
        
        func testInsertAndFetchLocalizations_Success() {
            // Insert fake localizations and fetch them
            let fakeLocalizations = [DBLocalization(
                id: "B93A51C8-C92C-44AE-B1D1-9AFE9BA0BCCC",
                latitud: "35.71867899343361",
                longitud: "139.8202084625344",
                hero: fakeGoku.first
                                                   )]
            storeDataProvider.insertLocalization(localization: fakeLocalizations)
            
            let fetchedLocations = storeDataProvider.fetchLocalization()
            XCTAssertFalse(fetchedLocations.isEmpty, "Fetching localizations not empty insertion")
            XCTAssertEqual(fetchedLocations.first?.heroes?.name, "Goku")
            XCTAssertEqual(fetchedLocations.first?.latitude, "35.71867899343361")
        }
        
        func testResetTransformLocation_Success() {
            storeDataProvider.resetTransformLocation()
            
            let fetchedTransforms = storeDataProvider.fetchTransform()
            let fetchedLocations = storeDataProvider.fetchLocalization()
            
            XCTAssertTrue(fetchedTransforms.isEmpty && fetchedLocations.isEmpty, "Transforms and locations empty after reset")
        }
        
        func testRemoveDDBB_Success() {
            // Test removing all data from the database
            storeDataProvider.removeDDBB()
            
            let fetchedHeroes = storeDataProvider.fetchHeroes()
            let fetchedTransforms = storeDataProvider.fetchTransform()
            let fetchedLocations = storeDataProvider.fetchLocalization()
            
            XCTAssertTrue(fetchedHeroes.isEmpty && fetchedTransforms.isEmpty && fetchedLocations.isEmpty, "All data removed from the database")
        }
        
        
}


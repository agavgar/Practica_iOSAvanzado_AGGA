//
//  LocationIUseCase.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/2/24.
//

import Foundation

protocol DetailUseCaseProtocol {
    func getLocalization(idHeroe: String, completion: @escaping (Result<[DBLocalization], NetworkErrors>)-> Void)
    func getTransform(idHeroe: String, completion: @escaping (Result<[DBTransformations], NetworkErrors>)-> Void)
    func getAllInfo(idHeroe: String,
                    completionTransform: @escaping (Result<[DBTransformations], NetworkErrors>)-> Void,
                    completionLocalization: @escaping (Result<[DBLocalization], NetworkErrors>)-> Void
    )
}

final class DetailUseCase: DetailUseCaseProtocol {
    
    private let APIProvider = ApiProvider()
    private let storeData = StoreDataProvider()
    
    func getTransform(idHeroe: String, completion: @escaping (Result<[DBTransformations], NetworkErrors>)-> Void){
        APIProvider.getData(endpoint: EndPoints.transform.rawValue, dataRequest: "id", value: idHeroe, completion: completion)
    }
    
    func getLocalization(idHeroe: String, completion: @escaping (Result<[DBLocalization], NetworkErrors>)-> Void){
        APIProvider.getData(endpoint: EndPoints.localization.rawValue, dataRequest: "id", value: idHeroe, completion: completion)
    }
    
    func getAllInfo(idHeroe: String,
                    completionTransform: @escaping (Result<[DBTransformations], NetworkErrors>)-> Void,
                    completionLocalization: @escaping (Result<[DBLocalization], NetworkErrors>)-> Void
    ) {
        
        let queueLoad = DispatchQueue(label: "Get Detail Info")
        let group = DispatchGroup()
        group.enter()
        queueLoad.async {
            self.getLocalization(idHeroe: idHeroe) { [weak self] (result: Result<[DBLocalization], NetworkErrors>) in
                switch result {
                case .success(let localizations):
                    // STORE DATA PROVIDER LOCALIZATION
                    self?.storeData.insertLocalization(localization: localizations)
                    break
                case .failure(let error):
                    print("Ha habido un error en DetailUseCase, getAllInfo en getLocalization y es \(error)")
                }
                group.leave()
            }
        }
        
        group.enter()
        queueLoad.async {
            self.getTransform(idHeroe: idHeroe) { [weak self] (result: Result<[DBTransformations], NetworkErrors>) in
                switch result {
                case .success(let transforms):
                    // STORE DATA PROVIDER TRANSFORM
                    self?.storeData.insert(transform: transforms)
                    break
                case .failure(let error):
                    print("Ha habido un error en DetailUseCase, getAllInfo en getTransform y es \(error)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            // Notificaciones
        }
        
    }
    
    
}

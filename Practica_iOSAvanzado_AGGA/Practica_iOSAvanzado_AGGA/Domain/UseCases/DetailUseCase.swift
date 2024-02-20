//
//  LocationIUseCase.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/2/24.
//

import Foundation

protocol DetailUseCaseProtocol {
    func getTransform(idHeroe: String, completion: @escaping (Result<[DBLocalization], NetworkErrors>)-> Void)
    func getAllInfo(idHeroe: String, completion: @escaping ()-> Void)
}

final class DetailUseCase: DetailUseCaseProtocol {
    
    private let APIProvider = ApiProvider()
    private let TransformMethod = TransformUseCase()
    
    func getTransform(idHeroe: String, completion: @escaping (Result<[DBLocalization], NetworkErrors>)-> Void){
        ApiProvider.getData(completion)
    }
    
    func getAllInfo(idHeroe: String, completion: @escaping () -> Void) {
        
        let queueLoad = DispatchQueue(label: "Get Detail Info")
        let group = DispatchGroup()
        group.enter()
        queueLoad.async {
            self.
        }
        
        
    }
    
    private func loadDataFromServices() {
            let queueLoad = DispatchQueue(label: "io.keepcoding.loadData")
            let group = DispatchGroup()
            group.enter()
            queueLoad.async {
                self.apiProvider.getBootcamps { result in
                    switch result {
                    case .success(let bootcamps):
                        self.storeDataProvider.insert(bootcamps: bootcamps)
                    case .failure(let error):
                        debugPrint("Error loading bootcamps (error.description)")
                    }
                    group.leave()
                }
            }

            group.enter()
            queueLoad.async {
                self.apiProvider.getDevelopers { result in
                    switch result {
                    case .success(let developers):
                        self.storeDataProvider.insert(developers: developers)
                    case .failure(let error):
                        debugPrint("Error loading developers (error.description)")
                    }
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                self.bootcamps = self.storeDataProvider.fetchBootCamps(sorting: self.sortDescriptor(ascending: false))
            }
        }

    
    
}

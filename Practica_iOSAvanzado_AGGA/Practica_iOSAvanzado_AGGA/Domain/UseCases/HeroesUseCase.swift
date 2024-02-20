//
//  HeroesUseCase.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/2/24.
//

import Foundation

protocol HeroesUseCaseProtocol {
    func getHeroes(completion: @escaping (Result<[DBHeroes], NetworkErrors>)-> Void)
}

final class HeroesUseCase: HeroesUseCaseProtocol{
    
    private let APIProvider = ApiProvider()
    
    func getHeroes(completion: @escaping (Result<[DBHeroes], NetworkErrors>) -> Void) {
        APIProvider.getData(endpoint: EndPoints.heroes.rawValue, dataRequest: "name", value: "", completion: completion)
    }
    
}

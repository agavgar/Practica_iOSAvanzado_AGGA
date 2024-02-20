//
//  HeroesViewModel.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/2/24.
//

import Foundation
import CoreData

final class HeroesViewModel {
    
    //MARK: - Binding con UI
    var dataUpdated: (() -> Void)?

    //MARK: - Extern models
    private let useCase: HeroesUseCaseProtocol
    private var storeData = StoreDataProvider()
    
    //MARK: - Intern models
    private var heroes: [NSMHeroes] = []
    
    //MARK: - Initializers
    deinit {
        // remove observer
    }
    
    init(useCase: HeroesUseCaseProtocol = HeroesUseCase(), storeData: StoreDataProvider = StoreDataProvider()){
        self.useCase = useCase
        self.storeData = storeData
        // Observer
    }
    
    //MARK: - Methods for table
    func loadHeroes() {
        
        // Limpia BBDD
        
        heroes = storeData.fetchHeroes(sorting: self.ordenNombre(ascending: false))
        
        if heroes.isEmpty{
            self.useCase.getHeroes { [weak self] result in
                
                switch result {
                case .success(let heroes):
                    self?.storeData.insert(heroes: heroes)
                case .failure(let error):
                    debugPrint("Error getting data in Heroes viewModel \(error)")
                }
                
            }
        }else{
            // notiify update data
        }
    }
    
    func numbOfHeroes() -> Int {
        return heroes.count
    }
    
    func idOfHero(indexPath: IndexPath) -> String? {
        guard indexPath.row < heroes.count else { return nil }
        return heroes[indexPath.row].id
    }
    
    //MARK: - Methods for sort info
    private func ordenNombreTransform(ascending: Bool = true) -> [NSSortDescriptor] {
        let sort = NSSortDescriptor(keyPath: \NSMHeroes.name, ascending: ascending)
        return [sort]
    }
    
    //MARK: - Notifications
}

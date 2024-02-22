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
    private var storeData: StoreDataProvider
    private var apiProvider: ApiProvider
    
    //MARK: - Intern models
    private var heroes: [NSMHeroes] = []
    
    //MARK: - Initializers
    deinit {
        removeObservers()
    }
    
    init(apiProvider: ApiProvider = ApiProvider(), storeData: StoreDataProvider = StoreDataProvider()){
        self.apiProvider = apiProvider
        self.storeData = storeData
        self.addObservers()
    }
    
    //MARK: - Methods for table
    func loadHeroes() {
        // Limpia BBDD
        //storeData.resetBBDD()
        heroes = storeData.fetchHeroes(sorting: self.sortByName(ascending: true))
        
        if heroes.isEmpty{
            apiProvider.getHeroes { [weak self] result in
                switch result {
                case .success(let heroes):
                    self?.storeData.insert(heroes: heroes)
                case .failure(let error):
                    debugPrint("Error getting data in Heroes viewModel \(error)")
                }
                
            }
        }else{
            notifyDataUpdated()
        }
    }
    
    func numbOfHeroes() -> Int {
        return heroes.count
    }
    
    func idOfHero(indexPath: IndexPath) -> String? {
        guard indexPath.row < heroes.count else { return nil }
        return heroes[indexPath.row].id
    }
    
    func heroesIn (indexPath: IndexPath) -> NSMHeroes? {
        guard indexPath.row < heroes.count else { return nil }
        return heroes[indexPath.row]
    }
    
    func notifyDataUpdated() {
        DispatchQueue.main.async {
            self.dataUpdated?()
        }
    }
    
    //MARK: - Methods for sort info
    private func sortByName(ascending: Bool = true) -> [NSSortDescriptor] {
        let sort = NSSortDescriptor(keyPath: \NSMHeroes.name, ascending: ascending)
        return [sort]
    }
    
    //MARK: - Notifications
    private func addObservers() {
        NotificationCenter.default.addObserver(forName: NSManagedObjectContext.didSaveObjectsNotification, object: nil, queue: .main) { notification in
            self.heroes = self.storeData.fetchHeroes(sorting: self.sortByName(ascending: false))
        }
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}

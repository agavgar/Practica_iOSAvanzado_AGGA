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
    private var filteredHeroes: [NSMHeroes] = []
    
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

        heroes = storeData.fetchHeroes(sorting: self.sortByName(ascending: true))
        filteredHeroes = heroes
        
        if heroes.isEmpty || filteredHeroes.isEmpty{
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
        //return heroes.count
        return filteredHeroes.count
    }
    
    func idOfHero(indexPath: IndexPath) -> String? {
        guard indexPath.row < heroes.count else { return nil }
        //return heroes[indexPath.row].id
        return filteredHeroes[indexPath.row].id
    }
    
    func heroesIn (indexPath: IndexPath) -> NSMHeroes? {
        guard indexPath.row < heroes.count else { return nil }
        //return heroes[indexPath.row]
        return filteredHeroes[indexPath.row]
    }
    
    func notifyDataUpdated() {
        DispatchQueue.main.async {
            self.dataUpdated?()
        }
    }
    
    func eraseAll(){
        storeData.removeDDBB()
        let secData = SecureData()
        secData.deleteToken()
    }
    
    //MARK: - Methods for DDBB info
    private func sortByName(ascending: Bool = true) -> [NSSortDescriptor] {
        let sort = NSSortDescriptor(keyPath: \NSMHeroes.name, ascending: ascending)
        return [sort]
    }
    
    func filterByName(searchBarText: String) {
        
        if searchBarText.isEmpty {
            filteredHeroes = heroes
        }else{
            let filter = NSPredicate(format: "name CONTAINS[cd] %@", searchBarText)
            filteredHeroes = storeData.fetchHeroes(filter: filter)
        }
        self.dataUpdated?()
        
    }
    
    //MARK: - Notifications
    private func addObservers() {
        NotificationCenter.default.addObserver(forName: NSManagedObjectContext.didSaveObjectsNotification, object: nil, queue: .main) { notification in
            self.heroes = self.storeData.fetchHeroes(sorting: self.sortByName(ascending: true))
        }
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}

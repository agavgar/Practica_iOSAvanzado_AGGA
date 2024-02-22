//
//  DetailViewModel.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/2/24.
//

import Foundation
import CoreData

final class DetailViewModel {
    
    //MARK: - Binding con UI
    var dataUpdated: (() -> Void)?

    //MARK: - Extern models
    private var storeData: StoreDataProvider
    private var apiProvider: ApiProvider
    
    //MARK: - Intern models
    var heroe: NSMHeroes?
    private var transform: [NSMTransforms] = []
    private var localization: [NSMLocation] = []
    
    //MARK: - Initializers
    deinit {
        removeObservers()
    }
    
    init(heroe: NSMHeroes? = nil, apiProvider: ApiProvider = ApiProvider(), storeData: StoreDataProvider = StoreDataProvider()){
        self.heroe = heroe
        self.apiProvider = apiProvider
        self.storeData = storeData
        addObservers()
    }
    
    //MARK: - Methods for table
    func loadInfo() {
        
        guard let hero = heroe else {
            print("Error retrieving id Hero from DataBase")
            return
        }
        
        guard let id = hero.id else {
            print("Error retrieving id Hero from DataBase")
            return
        }
        
        transform = storeData.fetchTransform()
        localization = storeData.fetchLocalization()
        
        if transform.isEmpty || localization.isEmpty {
            getAllInfo(idHeroe: id)
        }else{
            notifyDataUpdate()
        }
    }
    
    func notifyDataUpdate(){
        DispatchQueue.main.async {
            self.dataUpdated?()
        }
    }
    
    func numbOfTransform() -> Int {
        return transform.count
    }
    
    func transformIn (indexPath: IndexPath) -> NSMTransforms? {
        guard indexPath.row < transform.count else { return nil }
        return transform[indexPath.row]
    }
    
    //MARK: - Get All Info
    func getAllInfo(idHeroe: String) {
        
        let queueLoad = DispatchQueue(label: "Get Detail Info",attributes: .concurrent)
        let group = DispatchGroup()
        group.enter()
        queueLoad.async {
            self.apiProvider.getLocalization(idHeroe: idHeroe) { [weak self] (result: Result<[DBLocalization], NetworkErrors>) in
                switch result {
                case .success(let localizations):
                    self?.storeData.insertLocalization(localization: localizations)
                    break
                case .failure(let error):
                    print("Ha habido un error en DetailUseCase, getAllInfo en getLocalization y es \(error)")
                    break
                }
                group.leave()
            }
        }
        
        group.enter()
        queueLoad.async {
            self.apiProvider.getTransform(idHeroe: idHeroe) { [weak self] (result: Result<[DBTransformations], NetworkErrors>) in
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
            // Group Notify
            self.notifyDataUpdate()
        }
        
    }
    
    //MARK: - Methods for sort info
    private func sortNameTransform(ascending: Bool = true) -> [NSSortDescriptor] {
        let sort = NSSortDescriptor(keyPath: \NSMTransforms.name, ascending: ascending)
        return [sort]
    }
    
    private func filterByID(id: String) -> NSPredicate? {
        let filter = NSPredicate(format: "id == \(id)", heroe?.id ?? "")
        return filter
    }
    
    //MARK: - Notifications
    private func addObservers() {
        NotificationCenter.default.addObserver(forName: NSManagedObjectContext.didSaveObjectsNotification, object: nil, queue: .main) { notification in
            self.transform = self.storeData.fetchTransform(sorting: self.sortNameTransform(ascending: false))
            self.localization = self.storeData.fetchLocalization()
        }
    }
    
    private func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
}

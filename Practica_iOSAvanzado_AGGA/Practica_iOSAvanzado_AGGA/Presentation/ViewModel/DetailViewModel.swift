//
//  DetailViewModel.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/2/24.
//

import Foundation

final class DetailViewModel {
    
    //MARK: - Binding con UI
    var dataUpdated: (() -> Void)?

    //MARK: - Extern models
    private let useCase: DetailUseCaseProtocol
    private var storeData = StoreDataProvider()
    
    //MARK: - Intern models
    private var heroe: NSMHeroes
    private var transform: [NSMTransforms]
    private var localization: NSMLocation
    
    //MARK: - Initializers
    deinit {
        // remove observer
    }
    
    init(heroe: NSMHeroes,useCase: DetailUseCaseProtocol = DetailUseCase(), storeData: StoreDataProvider = StoreDataProvider()){
        self.heroe = heroe
        self.useCase = useCase
        self.storeData = storeData
        // Observer
    }
    
    //MARK: - Methods for table
    func loadInfo() {
        
        guard let id = heroe.id, let selectedHero = storeData.fetchHeroes(filter: filterByID(id: id)).first else {
            print("Error retrieving id Hero from DataBase")
            return
        }
        
        transform = storeData.fetchTransform()
        
        guard let localPosition = storeData.fetchLocalization().last else {
            print("Error gettig local position")
            return
        }
        localization = localPosition
        
        if transform.isEmpty || localization != localization {
            
            self.useCase.getAllInfo(idHeroe: id) { result in
                <#code#>
            } completionLocalization: { result in
                <#code#>
            }

            
            
        }else{
            // notiify update data
        }
    }
    
    func numbOfTransform() -> Int {
        return transform.count
    }
    
    //MARK: - Methods for sort info
    private func ordenNombreTransform(ascending: Bool = true) -> [NSSortDescriptor] {
        let sort = NSSortDescriptor(keyPath: \NSMTransforms.name, ascending: ascending)
        return [sort]
    }
    
    private func filterByID(id: String) -> NSPredicate? {
        let filter = NSPredicate(format: "id == \(id)", heroe.id ?? "")
    }
    
    //MARK: - Notifications
    
}

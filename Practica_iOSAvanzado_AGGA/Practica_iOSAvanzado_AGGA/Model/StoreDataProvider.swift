//
//  StoreDataProvider.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 14/2/24.
//

import Foundation
import CoreData

final class StoreDataProvider {
    
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("Error creating Stack Core Data \(error)")
            }
        }
    }
    
}

extension StoreDataProvider {
    
    func fetchURL(type: String) -> String {
        
        var endString:String?
        let context = context
        let request = NSFetchRequest<Endpoints>(entityName: "Endpoints")
        guard let endpoint = try? context.fetch(request).first else {
            return "Error fetching category"
        }
        
        let urlString = endpoint.url!
        
        if type == "login"{
            endString = endpoint.login
        }else if type == "heros"{
            endString = endpoint.heros
        }else if type == "transformations"{
            endString = endpoint.transformations
        }else if type == "localizations"{
            endString = endpoint.localizations
        }else{
            endString = "error"
        }
        
    
        return urlString + endString!
        
    }
    
    func fetchHeroes()->[Heroes]{
        let request = NSFetchRequest<Heroes>(entityName: "Heroes")
        let context = context
        let heroes =  try? context.fetch(request)
        return heroes ?? []
    }
    
    func save(){
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        }catch{
            debugPrint("Erro saving changes in context")
        }
    }
    
    
    
}

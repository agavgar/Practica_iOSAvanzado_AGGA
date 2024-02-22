//
//  StoreDataProvider.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 14/2/24.
//

import Foundation
import CoreData

enum StoreType {
    case disk
    case inMemory
}

final class StoreDataProvider {
    
    static var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: StoreDataProvider.self)
        guard  let url = bundle.url(forResource: "Model", withExtension: "momd"),
               let mom = NSManagedObjectModel(contentsOf: url) else {
            fatalError(" Error loading model file")
        }
        return mom
    }()
    
    let persistentContainer: NSPersistentContainer
    lazy var context: NSManagedObjectContext = {
        var viewContext = persistentContainer.viewContext
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return viewContext
    }()
    
    init(storeType: StoreType = .disk) {
        self.persistentContainer = NSPersistentContainer(name: "Model", managedObjectModel: Self.managedObjectModel)
        if  storeType == .inMemory {
            // Para persistir en memoria la BBDD debemos asignar la URL /dev/null al store Description
            // Para testing es necesario que la base de datos esté en memoria
            if let store = self.persistentContainer.persistentStoreDescriptions.first {
                store.url = URL(filePath: "dev/null")
            } else {
                fatalError(" Error loading persistent Store Description")
            }
        }
        self.persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Error creating BBDD \(error)")
            }
        }
    }
    
}

extension StoreDataProvider {
    
    func insert(heroes:[DBHeroes]){
        context.performAndWait {
            for heroe in heroes {
                let newHeroe = NSMHeroes(context: context)
                newHeroe.id = heroe.id
                newHeroe.info = heroe.description
                newHeroe.name = heroe.name
                newHeroe.photo = heroe.photo
                newHeroe.favorite = heroe.favorite ?? false
            }
            self.save()
        }
    }
    
    func fetchHeroes(filter: NSPredicate? = nil, sorting: [NSSortDescriptor]? = nil)-> [NSMHeroes] {
        let request = NSMHeroes.fetchRequest()
        request.predicate = filter
        request.sortDescriptors = sorting
        do{
            return try context.fetch(request)
        }catch{
            print("Fetch heroes fail")
            return []
        }
    }
    
    func insert(transform:[DBTransformations]){
        context.performAndWait {
            for evolution in transform {
                let newEvolution = NSMTransforms(context: context)
                newEvolution.id = evolution.id
                newEvolution.info = evolution.description
                newEvolution.name = evolution.name
                newEvolution.photo = evolution.photo
                let filter = NSPredicate(format: "id == %@", evolution.hero?.id ?? "")
                newEvolution.heroe = self.fetchHeroes(filter: filter).first
            }
            save()
        }
    }
    
    func fetchTransform(sorting: [NSSortDescriptor]? = nil) -> [NSMTransforms] {
        let request = NSMTransforms.fetchRequest()
        do {
            return try context.fetch(request)
        }catch {
            print("Fetch transform fail")
            return []
        }
    }
    
    func insertLocalization(localization:[DBLocalization]){
        context.performAndWait {
            for places in localization {
                let newLocalization = NSMLocation(context: context)
                newLocalization.id = places.id
                newLocalization.date = places.date
                newLocalization.latitude = places.latitude ?? "0"
                newLocalization.longitude = places.longitude ?? "0"
                let filter = NSPredicate(format: "id == $@", places.hero?.id ?? "")
                newLocalization.heroes = self.fetchHeroes(filter: filter).first
            }
            self.save()
        }
    }
    
    func fetchLocalization() -> [NSMLocation] {
        let request = NSMLocation.fetchRequest()
        do {
            return try context.fetch(request)
        }catch {
            print("Fetch transform fail")
            return []
        }
    }
    
    func save(){
        if context.hasChanges {
            do {
                try context.save()
            }catch{
                context.rollback()
                print("Error saving BBDD")
            }
        }
    }
    
    func resetBBDD(){
        let removeHeroes = NSBatchDeleteRequest(fetchRequest: NSMHeroes.fetchRequest())
        let removeTransform = NSBatchDeleteRequest(fetchRequest: NSMTransforms.fetchRequest())
        let removeLocation = NSBatchDeleteRequest(fetchRequest: NSMLocation.fetchRequest())
        context.reset()
        
        for task in [removeHeroes, removeTransform, removeLocation] {
            do {
                try  context.execute(task)
            } catch {
                debugPrint("Error cleaning BBDD")
            }
        }
    }
    
}

extension StoreDataProvider {
    func deleteDatabase() {
        guard let storeURL = self.persistentContainer.persistentStoreDescriptions.first?.url else {
            print("No se pudo encontrar la URL del almacén persistente.")
            return
        }

        do {
            let persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
            if let store = persistentStoreCoordinator.persistentStores.first {
                try persistentStoreCoordinator.remove(store)
                try FileManager.default.removeItem(at: storeURL)
                print("Base de datos eliminada exitosamente.")
            }
        } catch {
            print("Error al eliminar la base de datos: \(error)")
        }

        let walURL = storeURL.deletingPathExtension().appendingPathExtension("sqlite-wal")
           let shmURL = storeURL.deletingPathExtension().appendingPathExtension("sqlite-shm")
           
           [storeURL, walURL, shmURL].forEach { fileURL in
               if FileManager.default.fileExists(atPath: fileURL.path) {
                   do {
                       try FileManager.default.removeItem(at: fileURL)
                       print("Archivo \(fileURL.lastPathComponent) eliminado exitosamente.")
                   } catch {
                       print("Error al eliminar el archivo \(fileURL.lastPathComponent): \(error)")
                   }
               }
           }
    }
}

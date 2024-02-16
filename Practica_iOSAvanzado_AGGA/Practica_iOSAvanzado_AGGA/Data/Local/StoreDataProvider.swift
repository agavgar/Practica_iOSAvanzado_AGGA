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
    lazy var context: NSManagedObjectContext = {
        var viewContext = persistentContainer.viewContext
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return viewContext
    }()
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        
        if let store = self.persistentContainer.persistentStoreDescriptions.first {
            print("Store added")
        }
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Error creating Database \(error)")
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
                newHeroe.favorite = heroe.favorite
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
    
    func fetchTransform() -> [NSMTransforms] {
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
                newLocalization.latitude = places.latitude
                newLocalization.longitude = places.longitude
                let filter = NSPredicate(format: "id == $@", places.hero?.id ?? "")
                newLocalization.heroe = self.fetchHeroes(filter: filter).first
            }
            self.save()
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
        context.delete(NSMHeroes())
        context.delete(NSMTransforms())
        context.delete(NSMLocation())
    }
    
    
}

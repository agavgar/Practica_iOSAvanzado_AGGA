//
//  NSMLocation.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import UIKit
import CoreData

@objc(NSMLocation)
class NSMLocation: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSMLocation> {
        return NSFetchRequest<NSMLocation>(entityName: "Location")
    }
    
    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var heroe: NSMHeroes?
    
}





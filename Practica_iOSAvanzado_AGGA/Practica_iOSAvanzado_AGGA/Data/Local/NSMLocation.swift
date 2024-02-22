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
    
    @NSManaged public var date: String?
    @NSManaged public var id: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var heroes: NSMHeroes?
    
}





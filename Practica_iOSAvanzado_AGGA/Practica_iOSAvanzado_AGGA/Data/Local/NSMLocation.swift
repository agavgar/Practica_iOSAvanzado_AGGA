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
    
    public var date: Date?
    public var id: String?
    public var latitude: Float?
    public var longitude: Float?
    public var heroe: NSMHeroes?
    
}





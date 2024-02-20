//
//  NSMTransforms.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import UIKit
import CoreData

@objc(NSMTransforms)
class NSMTransforms: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSMTransforms> {
        return NSFetchRequest<NSMTransforms>(entityName: "Transforms")
    }

    @NSManaged public var id: String?
    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var heroe: NSMHeroes?

    
}

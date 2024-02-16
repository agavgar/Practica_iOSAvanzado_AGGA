//
//  NSMHeroes.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import UIKit
import CoreData

@objc(NSMHeroes)
class NSMHeroes: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSMHeroes> {
        return NSFetchRequest<NSMHeroes>(entityName: "Heroes")
    }

    public var id: String?
    public var name: String?
    public var info: String?
    public var photo: String?
    public var favorite:Bool?
    
    public var transformations: Set<NSMTransforms>?
    public var location: NSMLocation?

}

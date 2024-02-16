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

    public var id: String?
    public var name: String?
    public var info: String?
    public var photo: String?
    public var heroe: NSMHeroes?

    
}

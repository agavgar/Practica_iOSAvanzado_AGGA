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

    @NSManaged public var favorite: Bool
    @NSManaged public var id: String?
    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var location: Set<NSMLocation>?
    @NSManaged public var transformations: Set<NSMTransforms>?

}

// MARK: Generated accessors for transformations
extension NSMHeroes {

    @objc(addTransformationsObject:)
    @NSManaged public func addToTransformations(_ value: NSMTransforms)

    @objc(removeTransformationsObject:)
    @NSManaged public func removeFromTransformations(_ value: NSMTransforms)

    @objc(addTransformations:)
    @NSManaged public func addToTransformations(_ values: Set<NSMTransforms>)

    @objc(removeTransformations:)
    @NSManaged public func removeFromTransformations(_ values: Set<NSMTransforms>)

}

extension NSMHeroes {

    @objc(addLocationObject:)
    @NSManaged public func addToLocation(_ value: NSMLocation)

    @objc(removeLocationObject:)
    @NSManaged public func removeFromLocation(_ value: NSMLocation)

    @objc(addLocation:)
    @NSManaged public func addToLocation(_ values: Set<NSMLocation>)

    @objc(removeLocation:)
    @NSManaged public func removeFromLocation(_ values: Set<NSMLocation>)

}


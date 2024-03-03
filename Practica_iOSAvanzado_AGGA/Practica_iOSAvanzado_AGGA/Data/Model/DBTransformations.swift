//
//  Transformations.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import Foundation

struct DBTransformations: Codable {
    let id: String?
    let name: String?
    let description: String?
    let photo: String?
    let hero: DBHeroes?
    
}

extension DBTransformations: Equatable{
    
    static func == (lhs: DBTransformations, rhs: DBTransformations) -> Bool {
        return
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.photo == rhs.photo &&
        lhs.hero == rhs.hero
    }
    
}

//
//  Heroes.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import Foundation

struct DBHeroes: Codable {
    let name: String?
    let id: String?
    let favorite: Bool?
    let description: String?
    let photo: String?
}

extension DBHeroes: Equatable{
    
    static func == (lhs: DBHeroes, rhs: DBHeroes) -> Bool {
        return
        lhs.name == rhs.name &&
        lhs.id == rhs.id &&
        lhs.favorite == rhs.favorite &&
        lhs.description == rhs.description &&
        lhs.photo == rhs.photo
    }
    
}

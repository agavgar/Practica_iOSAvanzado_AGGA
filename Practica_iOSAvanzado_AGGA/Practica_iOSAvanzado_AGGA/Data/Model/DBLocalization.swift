//
//  Localization.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import Foundation

struct DBLocalization: Codable {
    let id: String?
    let latitud: String?
    let longitud: String?
    let hero: DBHeroes?
}

extension DBLocalization: Equatable{
    
    static func == (lhs: DBLocalization, rhs: DBLocalization) -> Bool {
        return
        lhs.id == rhs.id &&
        lhs.latitud == rhs.latitud &&
        lhs.longitud == rhs.longitud &&
        lhs.hero == rhs.hero
    }
    
}

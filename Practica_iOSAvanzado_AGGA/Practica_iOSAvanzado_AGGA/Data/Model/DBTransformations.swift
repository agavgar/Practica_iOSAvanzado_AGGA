//
//  Transformations.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import Foundation

struct DBTransformations: Decodable {
    let id: String?
    let name: String?
    let description: String?
    let photo: String?
    let hero: DBHeroes?
    
}

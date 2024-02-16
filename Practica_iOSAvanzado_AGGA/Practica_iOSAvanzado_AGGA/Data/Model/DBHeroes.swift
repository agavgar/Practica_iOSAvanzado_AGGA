//
//  Heroes.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import Foundation

struct DBHeroes: Decodable {
    let name: String?
    let id: String?
    let favorite: Bool?
    let description: String?
    let photo: String?
}

//
//  Localization.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import Foundation

struct DBLocalization: Decodable {
    let id: String?
    let date: Date?
    let latitude: Float?
    let longitude: Float?
    let hero: DBHeroes?
}

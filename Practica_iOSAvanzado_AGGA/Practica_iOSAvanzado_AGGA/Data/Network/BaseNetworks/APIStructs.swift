//
//  APIResponse.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

enum EndPoints: String{
    case url = "https://dragonball.keepcoding.education/api"
    case login = "/auth/login"
    case heroes = "/heros/all"
    case transform = "/heros/tranformations"
    case localization = "/heros/locations"
}

struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
    static let contentType = "application/json"
    static let auth = "Authorization"
}

struct HTTPResponseCodes {
    static let SUCCESS = 200
    static let NOT_AUTHORIZED = 401
    static let NOT_FOUND = 404
    static let BAD_SERVER = 500
}



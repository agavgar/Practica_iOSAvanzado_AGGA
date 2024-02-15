//
//  NetworkErrors.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 14/2/24.
//

enum NetworkErrors: Error {
    case malformedURL
    case statusCode(code:Int?)
    case failDecodingData
    case noData
    case tokenNotFound
    case unknown
}

extension NetworkErrors: Equatable{}

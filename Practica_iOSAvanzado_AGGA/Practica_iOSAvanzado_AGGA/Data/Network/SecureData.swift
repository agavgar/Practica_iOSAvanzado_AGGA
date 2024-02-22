//
//  SecureData.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/2/24.
//

import Foundation
import KeychainSwift

protocol SecureDataProtocol {
    func setToken(token: String)
    func getToken() -> String?
    func deleteToken()
}

final class SecureData: SecureDataProtocol {

    private let keychain = KeychainSwift()
    private let keyToken = "keyToken"
    
    func setToken(token: String){
        keychain.set(token, forKey: keyToken)
    }
    
    func getToken() -> String? {
        return keychain.get(keyToken)
    }
    
    func deleteToken() {
        keychain.delete(keyToken)
    }
    
}

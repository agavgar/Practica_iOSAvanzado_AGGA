//
//  MockSecureData.swift
//  Practica_IOSAvanzado_AGGATests
//
//  Created by Alejandro Alberto Gavira García on 28/2/24.
//

import Foundation

final class MockSecureData {
    
    var token: String?
    
    func setToken(token: String) {
        self.token = token
    }
    
    func getToken() -> String? {
        return token
    }
    
    func deleteToken() {
        self.token = nil
    }
    
    
}

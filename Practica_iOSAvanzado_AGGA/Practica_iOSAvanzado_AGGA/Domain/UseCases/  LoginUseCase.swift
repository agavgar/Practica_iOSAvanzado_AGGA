//
//    LoginUseCase.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 15/2/24.
//

import Foundation

protocol LoginUseCaseProtocol {
    func login(user: String, pass: String, completion: @escaping (Result<String,NetworkErrors>)->Void)
    func getHeroe(completion: @escaping (Result<Heroes,NetworkErrors>)->Void)
    func getTransform(completion: @escaping (Result<Transformations,NetworkErrors>)->Void)
}

final class LoginUseCase: LoginUseCaseProtocol{
    
    func login(user: String, pass: String, completion: @escaping (Result<String, NetworkErrors>) -> Void) {
        <#code#>
    }
    
    func getHeroe(completion: @escaping (Result<Heroes, NetworkErrors>) -> Void) {
        <#code#>
    }
    
    func getTransform(completion: @escaping (Result<Transformations, NetworkErrors>) -> Void) {
        <#code#>
    }
    
    
}


//MARK: - Fake Success
final class LoginUseCaseSucces: LoginUseCaseProtocol {
    func login(user: String, pass: String, completion: @escaping (Result<String, NetworkErrors>) -> Void) {
        <#code#>
    }
    
    func getHeroe(completion: @escaping (Result<Heroes, NetworkErrors>) -> Void) {
        <#code#>
    }
    
    func getTransform(completion: @escaping (Result<Transformations, NetworkErrors>) -> Void) {
        <#code#>
    }
    
    
}

//MARK: - Fake Error
final class LoginUseCaseFail: LoginUseCaseProtocol {
    func login(user: String, pass: String, completion: @escaping (Result<String, NetworkErrors>) -> Void) {
        <#code#>
    }
    
    func getHeroe(completion: @escaping (Result<Heroes, NetworkErrors>) -> Void) {
        <#code#>
    }
    
    func getTransform(completion: @escaping (Result<Transformations, NetworkErrors>) -> Void) {
        <#code#>
    }
    
    
}

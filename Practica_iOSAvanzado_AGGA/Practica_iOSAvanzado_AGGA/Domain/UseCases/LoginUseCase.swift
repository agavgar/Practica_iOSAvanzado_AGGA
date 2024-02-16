//
//    LoginUseCase.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 15/2/24.
//

import Foundation

protocol LoginUseCaseProtocol {
    func login(user: String, pass: String, completion: @escaping (Result<String,NetworkErrors>)->Void)
}

final class LoginUseCase: LoginUseCaseProtocol{
    
    func login(user: String, pass: String, completion: @escaping (Result<String, NetworkErrors>) -> Void) {
        guard let url = URL(string: "\(EndPoints.url.rawValue)\(EndPoints.login.rawValue)") else {
            completion(.failure(.malformedURL))
            return
        }
        
        let loginString = String(format: "%@:%@", user, pass)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.failDecodingData))
            return
        }
        
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.post
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: HTTPMethods.auth)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
            guard error == nil else {
                completion(.failure(.unknown))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            guard statusCode == HTTPResponseCodes.SUCCESS else {
                completion(.failure(.statusCode(code: statusCode)))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                completion(.failure(.tokenNotFound))
                return
            }
            
            //Aqui guardamos en keychain
            completion(.success(token))
            
            
        }
        task.resume()
    }
    
    
}


//MARK: - Fake Success
final class LoginUseCaseSucces: LoginUseCaseProtocol {
    func login(user: String, pass: String, completion: @escaping (Result<String, NetworkErrors>) -> Void) {
        
    }
    
    
    
    
}

//MARK: - Fake Error
final class LoginUseCaseFail: LoginUseCaseProtocol {
    func login(user: String, pass: String, completion: @escaping (Result<String, NetworkErrors>) -> Void) {
        
    }
    
    
    
}

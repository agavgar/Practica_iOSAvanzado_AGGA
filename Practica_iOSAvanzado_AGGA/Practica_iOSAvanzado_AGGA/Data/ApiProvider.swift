//
//  GenericUseCase.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import Foundation

final class ApiProvider {
    
    private let sessions: URLSession
    private let secureData: SecureDataProtocol
    
    init(sessions: URLSession = URLSession.shared, secureData: SecureDataProtocol = SecureData()) {
        self.sessions = sessions
        self.secureData = secureData
    }
    
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
        
        let task = sessions.dataTask(with: request) { data, response, error in
        
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
            self.secureData.setToken(token: token)
            completion(.success(token))
    
        }
        task.resume()
    }
    
    func getHeroes(completion: @escaping (Result<[DBHeroes], NetworkErrors>) -> Void) {
        getData(endpoint: EndPoints.heroes.rawValue, dataRequest: "name", value: "", completion: completion)
    }
    
    func getTransform(idHeroe: String, completion: @escaping (Result<[DBTransformations], NetworkErrors>)-> Void){
        getData(endpoint: EndPoints.transform.rawValue, dataRequest: "id", value: idHeroe, completion: completion)
    }
    
    func getLocalization(idHeroe: String, completion: @escaping (Result<[DBLocalization], NetworkErrors>)-> Void){
        getData(endpoint: EndPoints.localization.rawValue, dataRequest: "id", value: idHeroe, completion: completion)
    }
    
    func getData<T: Decodable>(endpoint:String, dataRequest: String, value: String , completion: @escaping (Result<T, NetworkErrors>) -> Void) {
        
        //1.URL
        guard let url = URL(string: "\(EndPoints.url.rawValue)\(endpoint)") else {
            completion(.failure(.malformedURL))
            return
        }
        
        //2. Token
        guard let token = secureData.getToken() else {
            debugPrint("Error with the token, Auth required")
            return
        }
        
        //3.Query
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name:dataRequest, value:value)]
    
        //4. Body

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.post
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: HTTPMethods.auth)
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
   
        let task = sessions.dataTask(with: urlRequest) { data,response,error in
            
            guard error == nil else {
                completion(.failure(.unknown))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            debugPrint("\(data)")
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            guard statusCode == HTTPResponseCodes.SUCCESS else {
                completion(.failure(.statusCode(code: statusCode)))
                return
            }
            
            guard let resource = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.failDecodingData))
                return
            }

            completion(.success(resource))
            
        }
        task.resume()
        
    }
    
    
}

//
//  GenericUseCase.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import Foundation

protocol GenericUseCaseProtocol {
    func getHeroes(completion: @escaping (Result<[DBHeroes], NetworkErrors>)-> Void)
    func getTransform(idHeroe: String, completion: @escaping (Result<[DBTransformations], NetworkErrors>)-> Void)
    func getLocalization(idHeroe: String, completion: @escaping (Result<[DBLocalization], NetworkErrors>)-> Void)
    func getData<T:Decodable>(endpoint: String, dataRequest: String, value: String, completion: @escaping (Result<T, NetworkErrors>)-> Void)
}

final class GenericUseCase: GenericUseCaseProtocol {
    
    func getHeroes(completion: @escaping (Result<[DBHeroes], NetworkErrors>) -> Void) {
        getData(endpoint: EndPoints.heroes.rawValue, dataRequest: "name", value: "", completion: completion)
    }
    
    func getTransform(idHeroe: String, completion: @escaping (Result<[DBTransformations], NetworkErrors>) -> Void) {
        getData(endpoint: EndPoints.transform.rawValue, dataRequest: "id", value: idHeroe, completion: completion)
    }
    
    func getLocalization(idHeroe: String, completion: @escaping (Result<[DBLocalization], NetworkErrors>) -> Void) {
        getData(endpoint: EndPoints.localization.rawValue, dataRequest: "id", value: idHeroe, completion: completion)
    }
    
    
    func getData<T: Decodable>(endpoint:String, dataRequest: String, value: String , completion: @escaping (Result<T, NetworkErrors>) -> Void) {
        
        //1.URL
        guard let url = URL(string: "\(EndPoints.url.rawValue)\(endpoint)") else {
            completion(.failure(.malformedURL))
            return
        }
        
        //2. Token
        let token = "eyJraWQiOiJwcml2YXRlIiwiYWxnIjoiSFMyNTYiLCJ0eXAiOiJKV1QifQ.eyJpZGVudGlmeSI6IjFBNDI0NDZFLUI5M0MtNEI3RS04MzQxLTBEQTVCOERCQjdDMiIsImVtYWlsIjoiYWxleC5nYXZpcmFAZ21haWwuY29tIiwiZXhwaXJhdGlvbiI6NjQwOTIyMTEyMDB9.ZHqui-H7UdhB7hF6Q8ecb8iellXjsI-UW359w3lZ158"
        
        //3.Query
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name:dataRequest, value:value)]
    
        //4. Body

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.post
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: HTTPMethods.auth)
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
   
        let task = URLSession.shared.dataTask(with: urlRequest) { data,response,error in
            
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
            
            guard let resource = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.failDecodingData))
                return
            }

            completion(.success(resource))
            
        }
        task.resume()
        
    }
    
}

//MARK: - Fake Success


//MARK: - Fake Error

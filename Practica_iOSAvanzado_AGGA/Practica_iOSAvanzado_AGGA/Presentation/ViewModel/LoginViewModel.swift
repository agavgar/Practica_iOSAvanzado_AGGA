//
//  LoginViewModel.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import Foundation

final class LoginViewModel{
    
    //MARK: - Extern models
    private let apiProvider = ApiProvider()
    private var storeData = StoreDataProvider()
    
    //MARK: - Validation Methods
    private func isValid(_ email: String,_ password: String) -> Bool {
        (email.isEmpty == false && email.contains("@")) || (password.isEmpty == false && password.count >= 4)
    }

    //MARK: - Metodo Login
    func onLoginButton(email: String?, password: String?, completion: @escaping((Bool) -> Void)) {
        guard let email = email, let password = password, isValid(email,password) else {
            print("Error, email o contraseña no son válidos. ")
            completion(false)
            return
        }
        
        apiProvider.login(user: email, pass: password) { result in
            switch result {
            case .success(_):
                completion(true)
                break
            case .failure(let error):
                debugPrint("Ha habido un error haciendo la conexión al login \(error)")
                completion(false)
            }
        }
    }
     
    
}

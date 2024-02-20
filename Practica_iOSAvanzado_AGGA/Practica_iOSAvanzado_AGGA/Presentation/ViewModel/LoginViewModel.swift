//
//  LoginViewModel.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import Foundation

final class LoginViewModel{
    
    //MARK: - Binding con UI
    var dataUpdated: (() -> Void)?

    //MARK: - Extern models
    private let useCase = LoginUseCase()
    private var storeData = StoreDataProvider()
    
    //MARK: - Validation Methods
    private func isValid(_ email: String,_ password: String) -> Bool {
        (email.isEmpty == false && email.contains("@")) || (password.isEmpty == false && password.count >= 4)
    }

    //MARK: - Metodo Login
    func onLoginButton(email: String?, password: String?) {
        //loginViewState?(.loading(true))
        
        //Check mail y password
        guard let email = email, let password = password, isValid(email,password) else {
            //loginViewState?(.loading(false))
            //loginViewState?(.loginError("email o contraseña incorrectos"))
            print("Error, email o contraseña no son válidos. ")
            return
        }
        
        useCase.login(user: email, pass: password) { [weak self] result in
            
            switch result {
            case .success(let token):
                // Guardar Token en KeyChain
                // Notificar
                break
            case .failure(let error):
                debugPrint("Ha habido un error haciendo la conexión al login \(error)")
            }
        }
    }
    
}

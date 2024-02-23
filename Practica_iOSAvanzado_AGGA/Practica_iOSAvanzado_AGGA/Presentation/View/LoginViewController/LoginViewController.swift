//
//  LoginViewController.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 16/2/24.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    //MARK: - Models
    private var viewModel: LoginViewModel
    
    //MARK: - Init
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - IBActions
    @IBAction func loginButton(_ sender: UIButton) {
        navigateHeroes()
    }
    
    //MARK: - Methods
    func navigateHeroes() {
        if !viewModel.onLoginButton(email: emailTextField.text, password: passTextField.text) {
            usernameLabel.text = "User or password is wrong"
            passwordLabel.text = "User or password is wrong"
            usernameLabel.textColor = .red
            passwordLabel.textColor = .red
        }else{
            navigateVC()
        }
    }
    
    func navigateVC(){
        DispatchQueue.main.async {
            let nextVM = HeroesViewModel()
            let nextVC = HeroesViewController(viewModel: nextVM)
            self.navigationController?.setViewControllers([nextVC], animated: true)
        }
    }
    
    func updateUI(){
     
        DispatchQueue.main.async {
            
        }
        
        
    }
    
}

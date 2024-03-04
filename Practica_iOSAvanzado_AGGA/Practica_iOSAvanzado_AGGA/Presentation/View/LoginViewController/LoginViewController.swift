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
    @IBOutlet weak var buttonLogin: UIButton!
    
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
        resetUI()
        
        self.hideKeyboard()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resetUI()
    }

    //MARK: - IBActions
    @IBAction func loginButton(_ sender: UIButton) {
        navigateHeroes()
    }
    
    //MARK: - Methods
    func navigateHeroes() {
        viewModel.onLoginButton(email: emailTextField.text, password: passTextField.text) { [weak self] isSuccess in
            switch isSuccess {
            case true:
                self?.navigateVC()
            case false:
                self?.updateUIError()
            }
        }
    }
    
    func navigateVC(){
        DispatchQueue.main.async {
            let nextVM = HeroesViewModel()
            let nextVC = HeroesViewController(viewModel: nextVM)
            self.navigationController?.setViewControllers([nextVC], animated: true)
        }
    }
    
    func updateUIError(){
        DispatchQueue.main.async {
            self.usernameLabel.text = "User or password is wrong"
            self.passwordLabel.text = "User or password is wrong"
            self.usernameLabel.textColor = .red
            self.passwordLabel.textColor = .red
        }
    }
    
    func resetUI(){
        DispatchQueue.main.async {
            self.buttonLogin.tintColor = .yellow
            self.usernameLabel.text = ""
            self.passwordLabel.text = ""
            self.usernameLabel.textColor = .yellow
            self.passwordLabel.textColor = .yellow
        }
    }
    
    func hideKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.hideKeyboardOBJC))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboardOBJC(){
        view.endEditing(true)
    }
    
    
    
    
}

//
//  LoginController.swift
//  Afet
//
//  Created by Baris on 31.05.2023.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - UI Elements
    private let image: UIImageView  = {
        let image = UIImageView()
        image.image = UIImage(named: "login")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Mail adresinizi giriniz"
        text.borderStyle = .roundedRect
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 7
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let passwordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Şifrenizi giriniz"
        text.borderStyle = .roundedRect
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 7
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isSecureTextEntry = true
        return text
    }()
    private let registerButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hesabınız yok mu? Kayıt olmak için tıklayınız", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Giriş Yap", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.3058823529, blue: 0.3098039216, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()

    private let stackView = UIStackView()
    //MARK: - Properties
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    //MARK: - Functions
    private func setup() {
        style()
        layout()
        setupTextFields()
        keyboardSettings()
        
    }
    
    //MARK: - Actions
    func setupTextFields() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Tamam", style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}

//MARK: - Selector
extension LoginController{
    
    //register button
    @objc private func handleRegisterButton(_ sender: UIButton) {
        let controller = RegisterController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //login button
    @objc private func handleLoginButton(_ sender: UIButton) {
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        
        AuthenticationService.login(email: emailText, password: passwordText) { data , error in
            if let error = error {
                print(error.localizedDescription)
                AlertMessage.alertMessageShow(title: .error, message: "\(error.localizedDescription)", viewController: self)
                return
            } else {
                
                let controller = HomeController()
                self.navigationController?.pushViewController(controller, animated: true)
                print("success")
            }
        }
    }
    
    
    //keyboard
    @objc private func handleKeyboardWillShow(){
        self.view.frame.origin.y = -110
    }
    @objc private func handleKeyboardWillHide(){
        self.view.frame.origin.y = 0
    }
    
}





//MARK: - Helpers
extension LoginController {
    
    //keyboard settings
    private func keyboardSettings() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func style() {
        view.backgroundColor = #colorLiteral(red: 0.9534673095, green: 0.9368072152, blue: 0.9117549062, alpha: 1)
        
        
        view.addSubview(image)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registerButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            
            //image
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            //stackView
            stackView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            //others
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 170),
            image.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

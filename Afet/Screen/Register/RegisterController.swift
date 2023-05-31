//
//  RegisterController.swift
//  Afet
//
//  Created by Baris on 31.05.2023.
//

import Foundation
import UIKit

class RegisterController: UIViewController {
    
    //MARK: - UI Elements
    private let nameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter your name"
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lastNameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter your surname"
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter your mail"
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let passwordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter your password"
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isSecureTextEntry = true
        return text
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
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
        keyboardSettings()
    }
    
    //MARK: - Actions
    
}


//MARK: - Selector
extension RegisterController {
    @objc private func handleRegisterButton(_ sender: UIButton) {
          guard let nameText = nameTextField.text else {return}
          guard let surnameText = lastNameTextField.text else {return}
          guard let emailText = emailTextField.text else {return}
          guard let passwordText = passwordTextField.text else {return}
          
          let user = IAuthenticationService(emailText: emailText, passwordText: passwordText, nameText: nameText, surnameText: surnameText)
          AuthenticationService.createUser(user: user) { error in
              if let error = error {
                  print(error.localizedDescription)
                  AlertMessage.alertMessageShow(title: .error, message: "\(error.localizedDescription)", viewController: self)
                  return
              } else {
                  let controller = HomeController()
                  self.navigationController?.pushViewController(controller, animated: true)
                  print("success")
                  AlertMessage.alertMessageShow(title: .success, message: "Kayıt başarılı.", viewController: self)
              }
              
          }
          
      }
      
    
    @objc private func handleTextField(_ sender: UITextField){
    
    }
    
    @objc private func handleKeyboardWillShow(){
        self.view.frame.origin.y = -110
    }
    @objc private func handleKeyboardWillHide(){
        self.view.frame.origin.y = 0
    }
}
//MARK: - Helpers
extension RegisterController {
    
    private func keyboardSettings() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
  
    private func style() {
        
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            
        ])
    }
}
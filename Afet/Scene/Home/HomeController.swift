//
//  ViewController.swift
//  Afet
//
//  Created by Baris on 30.05.2023.
//

import UIKit
import FirebaseAuth

private let reuserIdentifier = "cell"
class HomeController: UIViewController {
    //MARK: - UI Elements
    private lazy var helpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Yardım Et", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.7921568627, blue: 0.6470588235, alpha: 1)

        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHelpButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var getHelpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Yardım Al", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8078431373, green: 0.6705882353, blue: 0.5764705882, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleGetHelpButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var listAidsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Yardımları Listele", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.7362564206, green: 0.6142653823, blue: 0.5249872804, alpha: 1)

        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleListButton), for: .touchUpInside)
        return button
    }()
    
    private let stackView = UIStackView()
   
    //MARK: - Properties
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .white
    }
    
    //MARK: - Functions
    private func setup() {
        style()
        layout()
        setupBarButtonItem()
    }
    
  
    //MARK: - Functions
    private func setupBarButtonItem() {
           self.navigationItem.hidesBackButton = true
           self.navigationController?.navigationBar.prefersLargeTitles = true
           
           self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Çıkış Yap ", style: .done, target: self, action: #selector(handleExitButton))
       }
    
}

//MARK: - Selector
extension HomeController {
    @objc private func handleHelpButton(_ sender: UIButton) {
        let controller = HelpController()
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc private func handleGetHelpButton(_ sender: UIButton) {
        let controller = GetHelpController()
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc private func handleListButton(_ sender: UIButton) {
        let controller = ListTabbarController()
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc private func handleExitButton() {
          do{
              try Auth.auth().signOut()
              DispatchQueue.main.async {
                  let controller = UINavigationController(rootViewController: LoginController())
                  controller.modalPresentationStyle = .fullScreen
                  self.present(controller, animated: true)
              }
          }catch{
              
          }
      }

}

//MARK: - Helpers
extension HomeController {
    private func style() {
        self.title = "Listeler"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.addSubview(stackView)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(helpButton)
        stackView.addArrangedSubview(getHelpButton)
        stackView.addArrangedSubview(listAidsButton)
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually

    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor, constant: -15)

        ])
    }
}



//
//  ViewController.swift
//  Afet
//
//  Created by Baris on 30.05.2023.
//

import UIKit

private let reuserIdentifier = "cell"
class HomeController: UIViewController {
    //MARK: - UI Elements
    private lazy var helpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Yardım Et", for: .normal)
        button.backgroundColor = .blue
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
        button.backgroundColor = .magenta
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
        button.backgroundColor = .orange
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleListButton), for: .touchUpInside)
        return button
    }()
    
   
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
    }
    
  
    //MARK: - Actions
    
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
        let controller = HelpListController()
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

}

//MARK: - Helpers
extension HomeController {
    private func style() {
        self.title = "Listeler"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(helpButton)
        view.addSubview(getHelpButton)
        view.addSubview(listAidsButton)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            helpButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            helpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            helpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            helpButton.heightAnchor.constraint(equalToConstant: 150),
            
            
            getHelpButton.topAnchor.constraint(equalTo: helpButton.bottomAnchor, constant: 20),
            getHelpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            getHelpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            getHelpButton.heightAnchor.constraint(equalToConstant: 150),
            
            listAidsButton.topAnchor.constraint(equalTo: getHelpButton.bottomAnchor, constant: 20),
            listAidsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            listAidsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            listAidsButton.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
}



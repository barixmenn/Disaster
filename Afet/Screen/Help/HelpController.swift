//
//  HelpController.swift
//  Afet
//
//  Created by Baris on 31.05.2023.
//

import Foundation
import UIKit

class HelpController: UIViewController {
    //MARK: - UI Elements
    
    private let nameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Lütfen adınızı ve soyadınızı giriniz"
        text.borderStyle = .roundedRect
        return text
    }()
    
    private let emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Lütfen mail hesabınızı giriniz"
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let tcNumberTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Türkiye Cumhuriyeti kimlik numaranızı giriniz"
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        text.keyboardType = .numberPad
        return text
    }()
    
    private let phoneNumberTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Lütfen telefon numaranızı giriniz"
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        text.keyboardType = .phonePad
        return text
    }()
    
    lazy var categoryPickerView: UIPickerView = {
           let pv = UIPickerView()
        pv.backgroundColor = UIColor(named: "5a92af")
        return pv
       }()
        
    
    
    private let helpButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Yardım Et", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.tintColor = .white
        return button
    }()
    
    private lazy var infoButton : UIButton = {
        let button = UIButton()
        button.setTitle("Türkiye Cumhuriyeti numaram neden gerekiyor?", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleInfoButton), for: .touchUpInside)
        return button
    }()
    
    private let stackView = UIStackView()
    //MARK: - Properties
    var ihtiyac = ["Pantolon", "Battaniye", "Yorgan", "Ayakkabı", "Şapka"]
    var indexOfPicker = Int()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
    }
    
    //MARK: - Functions
    private func setup() {
        style()
        layout()
    }
    
    //MARK: - Actions
    
}

//MARK: - Selector
extension HelpController {
    @objc private func handleInfoButton(_ sender: UIButton) {
        let controller = InfoController()
               if let sheet = controller.sheetPresentationController {
                   sheet.detents = [.medium()]
               }
               self.present(controller, animated: true)
           }
    }


//MARK: - Helpers
extension HelpController {
    private func style() {
        self.title = "Yardım Et"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addSubview(stackView)
        categoryPickerView.tag = 1
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(tcNumberTextField)
        stackView.addArrangedSubview(phoneNumberTextField)
        stackView.addArrangedSubview(categoryPickerView)
        stackView.addArrangedSubview(helpButton)
        stackView.addArrangedSubview(infoButton)


        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            tcNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            helpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
}


extension HelpController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return ihtiyac.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1 :
            return ihtiyac[row]
        default:
            return "no data "
        }
    }
}

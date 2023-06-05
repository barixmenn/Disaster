//
//  HelpController.swift
//  Afet
//
//  Created by Baris on 31.05.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class HelpController: UIViewController {
    //MARK: - UI Elements
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Lütfen başında 0 olmadan giriniz"
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(10)
        return label
    }()
    private let phoneNumberTextField: UITextField = {
        let inputTextView = UITextField()
        inputTextView.placeholder = "Lütfen telefon numaranızı giriniz"
        inputTextView.borderStyle = .roundedRect
        inputTextView.layer.borderWidth = 1
        inputTextView.layer.cornerRadius = 7
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        inputTextView.keyboardType = .phonePad
        return inputTextView
    }()
    
    private let nameTextField: UITextField = {
        let inputTextView = UITextField()
        inputTextView.placeholder = "Lütfen adınızı giriniz"
        inputTextView.borderStyle = .roundedRect
        inputTextView.layer.borderWidth = 1
        inputTextView.layer.cornerRadius = 7
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        return inputTextView
    }()
    
    
    private let categoryPickerTextField: UITextField = {
        let inputTextView = UITextField()
        inputTextView.placeholder = "Lütfen bir seçim yapınız"
        inputTextView.borderStyle = .roundedRect
        inputTextView.layer.borderWidth = 1
        inputTextView.layer.cornerRadius = 7
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        return inputTextView
    }()
    private lazy var categoryPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = UIColor(named: "5a92af")
        return pv
    }()
    
    private let pieceTextField: UITextField = {
        let inputTextView = UITextField()
        inputTextView.placeholder = "Lütfen bir adet giriniz"
        inputTextView.borderStyle = .roundedRect
        inputTextView.layer.borderWidth = 1
        inputTextView.layer.cornerRadius = 7
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        return inputTextView
    }()

    
    private lazy var  helpButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Yardım Et", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.3058823529, blue: 0.3098039216, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleHelpButton), for: .touchUpInside)
        return button
    }()

    
    private let stackView = UIStackView()
    //MARK: - Properties
    var ihtiyac = ["Pantolon", "Battaniye", "Yorgan", "Ayakkabı", "Şapka"]
    var indexOfPicker = Int()
    private let viewModel = HelpViewModel()
    
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
    
    
    private func createToolbar() -> UIToolbar {
        let tool = UIToolbar()
        tool.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        tool.setItems([done], animated: true)
        
        return tool
    }
}


//MARK: - Selector
extension HelpController {
    @objc private func handleHelpButton(_ sender: UIButton) {
        guard let name = nameTextField.text else {return}
        guard let phone = phoneNumberTextField.text else {return}
        guard let need = categoryPickerTextField.text else {return}
        guard let piece = pieceTextField.text else {return}
    
        viewModel.addHelp(name: name, phone: phone, need: need, piece: piece, controller: self)
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
    }
}


//MARK: - Helpers
extension HelpController {
    private func style() {
        view.backgroundColor = #colorLiteral(red: 0.9534673095, green: 0.9368072152, blue: 0.9117549062, alpha: 1)

        categoryPickerTextField.inputView = categoryPickerView
        categoryPickerTextField.inputAccessoryView = createToolbar()
        self.title = "Yardım Et"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        categoryPickerView.tag = 1
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(phoneNumberTextField)
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(categoryPickerTextField)
        stackView.addArrangedSubview(pieceTextField)
        stackView.addArrangedSubview(helpButton)
        
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            categoryPickerTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            pieceTextField.heightAnchor.constraint(equalToConstant: 50),
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryPickerTextField.text = ihtiyac[row]
    }
}

//
//  GetHelpController.swift
//  Afet
//
//  Created by Baris on 31.05.2023.
//

import Foundation
import UIKit

class GetHelpController: UIViewController {
    
    
    //MARK: - UI Elements
    
    private let nameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Lütfen isminizi giriniz"
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        text.keyboardType = .numberPad
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
    
    private let locationTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Lütfen yaşadığını ili ve ilçeyi giriniz"
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    private let categoryPickerTextField: UITextField = {
        let inputTextView = UITextField()
        
        inputTextView.borderStyle = .roundedRect
        inputTextView.placeholder = "Lütfen bir seçim yapınız"
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        return inputTextView
    }()
    private lazy var categoryPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = UIColor(named: "5a92af")
        return pv
    }()
    
    private let helpButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Yardım Al", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleHelpButton), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private lazy var infoButton : UIButton = {
        let button = UIButton()
        button.setTitle("Türkiye Cumhuriyeti numaram neden gerekiyor?", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 10)
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
    
    //MARK: - Functions
    private func createToolbar() -> UIToolbar {
        let tool = UIToolbar()
        tool.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        tool.setItems([done], animated: true)
        
        return tool
    }
    
}

//MARK: - Selector
extension GetHelpController {
    
    @objc func donePressed() {
        self.view.endEditing(true)
    }
    
    @objc private func handleInfoButton(_ sender: UIButton) {
        let controller = InfoController()
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(controller, animated: true)
    }
    
    
    @objc private func handleHelpButton(_ sender: UIButton) {
        guard let name = nameTextField.text else {return}
        guard let phone = phoneNumberTextField.text else {return}
        guard let tc = tcNumberTextField.text else {return}
        guard let need =  categoryPickerTextField.text else {return}
        
        if name != "" || phone != "" || need != "" || tc != ""  {
            HelpService.getHelp(name: name , phone: phone, tc: tc, need: need) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    AlertMessage.alertMessageShow(title: .success, message: "Başarılı bir şekilde kaydedildi.", viewController: self)
                    self.dismiss(animated: true)
                }
            }
        } else {
            AlertMessage.alertMessageShow(title: .error, message: "Lütfen alanları kontrol ediniz", viewController: self)
        }
        
    }
}


//MARK: - Helpers
extension GetHelpController {
    private func style() {
        categoryPickerTextField.inputView = categoryPickerView
        categoryPickerTextField.inputAccessoryView = createToolbar()
        self.title = "Yardım Al"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addSubview(stackView)
        categoryPickerView.tag = 1
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(tcNumberTextField)
        stackView.addArrangedSubview(phoneNumberTextField)
        stackView.addArrangedSubview(locationTextField)
        stackView.addArrangedSubview(categoryPickerTextField)
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
            
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            tcNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            categoryPickerTextField.heightAnchor.constraint(equalToConstant: 50),
            locationTextField.heightAnchor.constraint(equalToConstant: 50),
            helpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
}


extension GetHelpController: UIPickerViewDataSource, UIPickerViewDelegate {
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

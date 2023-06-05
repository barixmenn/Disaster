//
//  InfoController.swift
//  Afet
//
//  Created by Baris on 31.05.2023.
//

import Foundation
import UIKit

class InfoController: UIViewController {
    //MARK: - UI Elements
    private let infoLabel : UILabel = {
        let label = UILabel()
        label.text = "Yardım ettikten sonra kayıtlara doğru bir biçimde eklemek için gereklidir."
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Properties
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .lightGray
        
    }
    
    //MARK: - Functions
    private func setup() {
        style()
        layout()
    }
    
    //MARK: - Actions
    
}


//MARK: - Helpers
extension InfoController {
    private func style() {
        view.addSubview(infoLabel)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
}

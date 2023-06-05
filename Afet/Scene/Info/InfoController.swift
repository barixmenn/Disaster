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
        label.text = "Afet yardım uygulamamıza hoş geldiniz! Yardım talebi oluştururken TC numaranızı talep etmemizin nedeni, size daha hızlı ve etkili bir şekilde yardımcı olabilmemizdir. TC numarası, yardım taleplerini kaydedip takip ederken doğrulama ve kimlik teyidi amacıyla kullanılmaktadır. Bu sayede, afetzedelerin daha öncelikli ve ihtiyaçlarına yönelik yardım sağlanması sağlanırken, hızlı ve etkin bir yardım süreci sunmaya çalışıyoruz. Sizin güvenliğiniz bizim için büyük önem taşımaktadır. TC numaraları ve diğer kişisel bilgileriniz, gizlilik politikamız doğrultusunda korunmaktadır ve yalnızca yardım süreciyle ilgili yetkili personel tarafından erişilebilmektedir. Lütfen unutmayın ki TC numaranız sadece yardım talepleriyle sınırlı bir şekilde kullanılacak olup, hiçbir şekilde üçüncü taraflarla paylaşılmayacaktır. Amacımız, sizlere yardım edebilmek ve afet sonrası zor durumda olan insanlara destek sağlamaktır."
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Properties
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .tertiarySystemBackground
        
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

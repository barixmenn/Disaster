//
//  NeedHelpCellList.swift
//  Afet
//
//  Created by Baris on 5.06.2023.
//

import Foundation
import UIKit

class NeedHelpCellList: UICollectionViewCell {
    
    //MARK: - UI Elements

    let needName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    let needPiece: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "test"
        label.numberOfLines = 0
        return label
    }()

    
    private var helpStackView = UIStackView()
    
    //MARK: - Properties
    var help : Help? {
        didSet {configure()}
    }
    var index : Int?
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension NeedHelpCellList {
    private func style() {
        helpStackView.translatesAutoresizingMaskIntoConstraints = false
        
        helpStackView.addArrangedSubview(needName)
        helpStackView.addArrangedSubview(needPiece)

        helpStackView.axis = .vertical
        
        backgroundColor = .white.withAlphaComponent(0.9)
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 2
    }
    
    private func  layout() {
        addSubview(helpStackView)
        NSLayoutConstraint.activate([

            helpStackView.topAnchor.constraint(equalTo: topAnchor),
            helpStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            trailingAnchor.constraint(equalTo: helpStackView.trailingAnchor,constant: 3),
            bottomAnchor.constraint(equalTo: helpStackView.bottomAnchor, constant: 8),
            

            
        ])
    }
    
    private func configure() {
        guard let help = self.help else {return}
        DispatchQueue.main.async {
            self.needName.text = help.helpName
            self.needPiece.text = "Adet: \(help.helpPiece)"

        }
    }
    
    
}

//
//  AllHelpListController.swift
//  Afet
//
//  Created by Baris on 2.06.2023.
//

import Foundation
import UIKit
import FirebaseAuth

private let reuseIdentifier = "cell"
class NeedHelpListController: UIViewController {
    
    
    //MARK: - UI Elements
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    //MARK: - Properties

    private var needHelp : [Help]? {
        didSet{ self.collectionView.reloadData() }
    }
    
    var user: User? {
        didSet { configure()}
    }

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    //MARK: - Functions
    private func setup() {
        style()
        layout()
    }

}



//MARK: - Service
extension NeedHelpListController {

    private func fetchUser() {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            UserService.fetchUser(uid: uid) { user in
                self.user = user
            }
        }
    
    private func fetchTask(id: String) {
        HelpService.fetchNeedHelp(uid: id) { needHelps in
            self.needHelp = needHelps
        }
    }
}
    

//MARK: - Helpers
extension NeedHelpListController {
    
    private func style(){
        self.navigationController?.title = "Yardım taleplerim"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        
        collectionView.register(NeedHelpCellList.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
    }
    private func layout(){
        view.addSubview(collectionView)
        
        //Constraint
        NSLayoutConstraint.activate([

            //collection view
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 14)
        ])
    }
    
    private func configure() {
        guard let user = self.user else {return}
        fetchTask(id: user.id)
        }
}

//MARK: - UICollectionViewDataSource
extension NeedHelpListController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.needHelp?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NeedHelpCellList
        cell.help = self.needHelp?[indexPath.row]
        return cell
    } 
}

//MARK: - UICollectionViewDelegate
extension NeedHelpListController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width * 0.9, height: 70)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 10, height: 10)
    }
}




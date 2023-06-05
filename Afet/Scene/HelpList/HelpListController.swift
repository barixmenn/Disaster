//
//  HelpListController.swift
//  Afet
//
//  Created by Baris on 31.05.2023.
//

import Foundation
import UIKit
import FirebaseAuth

private let reuseIdentifier = "cell"
class HelpListController: UIViewController {
    
    
    //MARK: - UI Elements
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    //MARK: - Properties

    private var helps = [Help]()
    
    var user: User? {
        didSet { configure()}
    }

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
        fetchTask()
    }
    
    //MARK: - Functions
    private func setup() {
        style()
        layout()
        fetchUser()
        
    }

}



//MARK: - Service
extension HelpListController {
    
    private func fetchUser() {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            UserService.fetchUser(uid: uid) { user in
                self.user = user
            }
        }
    
    private func fetchTask() {
        guard let id = self.user?.id else {return}
        HelpService.fetchHelp(uid: id) { helps  in
            self.helps = helps
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
      
        
    }
}
    

//MARK: - Helpers
extension HelpListController {
    
    private func style(){
        self.navigationController?.title = "Yardımlarım"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        
        collectionView.register(HelpListCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
            fetchTask()
        }
}

//MARK: - CollectionViewDataSource
extension HelpListController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HelpListCell
        cell.help = helps[indexPath.row]
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension HelpListController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width * 0.9, height: 70)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 10, height: 10)
    }
}




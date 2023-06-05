//
//  ListTabbarController.swift
//  Afet
//
//  Created by Baris on 2.06.2023.
//

import Foundation
import UIKit

class ListTabbarController: UITabBarController {
    // MARK: - Properties
    let helpList = HelpListController()  
    let allHelpList = NeedHelpListController()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        style()
    }
    
}



// MARK: - Helpers
extension ListTabbarController{
    private func style(){
        viewControllers = [configureViewController(rootViewController: helpList, title: "Yardımlarım", image: "checkmark.circle"),
                           configureViewController(rootViewController: allHelpList, title: "Yardım taleplerim", image: "clock.badge.checkmark")
        ]
    }
    
    
    private func configureViewController(rootViewController: UIViewController, title: String, image: String)-> UINavigationController{
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: image)
        return controller
    }
    
}

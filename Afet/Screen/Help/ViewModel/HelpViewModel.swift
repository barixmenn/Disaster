//
//  HelpViewModel.swift
//  Afet
//
//  Created by Baris on 5.06.2023.
//

import Foundation
import UIKit

protocol IHelpViewModel{
    func addHelp(name:String,phone:String,need:String,piece:String, controller: UIViewController)
}

class HelpViewModel : IHelpViewModel{
    
    
    func addHelp(name:String,phone:String,need:String,piece:String, controller: UIViewController) {
        if name != "" || phone != "" || need != "" || piece != "" || controller != nil  {
            HelpService.addHelp(name: name , phone: phone , need: need, piece: piece) { error in
                if let error = error {
                    print(error.localizedDescription)
                    AlertMessage.alertMessageShow(title: .error, message: "Lütfen kontrol ediniz.", viewController: controller)
                    return
                } else {
                    AlertMessage.alertMessageShow(title: .success, message: "İşleminiz başarıyla gerçekleşmiştir.", viewController: controller)
                }
            }
        } else {
            AlertMessage.alertMessageShow(title: .error, message: "Lütfen kontrol ediniz.", viewController: controller)
        }
    }
}


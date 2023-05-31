//
//  Alert.swift
//  Afet
//
//  Created by Baris on 31.05.2023.
//

import Foundation
import UIKit

enum successOrError : String {
    case error = "Error"
    case success = "Success"
}


final class AlertMessage {
    static func alertMessageShow(title : successOrError,message : String,viewController: UIViewController) {
        let alertController = UIAlertController(title: title.rawValue, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .destructive)
        alertController.addAction(okButton)
        viewController.present(alertController, animated: true)
    }
}

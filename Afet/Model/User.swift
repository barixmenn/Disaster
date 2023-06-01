//
//  Help.swift
//  Afet
//
//  Created by Baris on 1.06.2023.
//

import Foundation
import FirebaseFirestore


struct Help {
    let id : String
    let name : String
    let surname : String
    let email: String
    let password: String
    let timestamp: Timestamp
    
    
    init(data: [String: Any]) {
         self.id = data["id"] as? String ?? ""
         self.name = data["name"] as? String ?? ""
         self.surname = data["surname"] as? String ?? ""
         self.email = data["email"] as? String ?? ""
         self.password = data["password"] as? String ?? ""
         self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
     }
}

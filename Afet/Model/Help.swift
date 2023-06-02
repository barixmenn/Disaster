//
//  Help.swift
//  Afet
//
//  Created by Baris on 2.06.2023.
//

import Foundation
import FirebaseFirestore


struct Help{
    let helpId: String
    let helpName: String
    let helpPiece : String

    
    init(data: [String: Any]) {
        self.helpId = data["helpId"] as? String ?? ""
        self.helpName = data["need"] as? String ?? ""
        self.helpPiece = data["piece"] as? String ?? ""
    }
}

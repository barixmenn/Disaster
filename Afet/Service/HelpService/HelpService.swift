//
//  HelpService.swift
//  Afet
//
//  Created by Baris on 1.06.2023.
//

import FirebaseAuth
import FirebaseFirestore

class HelpService {
    
    static let shared = HelpService()
    
    static func addHelp(name: String, phone: String, tc: String,need: String, completion: @escaping (Error?) -> Void) {
        guard let currentId = Auth.auth().currentUser?.uid else {return}
        
        let helpId = NSUUID().uuidString
        
        let data = [
            "name" : name,
            "phone": phone,
            "tc" : tc,
            "need" : need,
            "helpId" : helpId,
            "timestamp" : Timestamp(date: Date())
        ] as [String: Any]
        
        COLLECTION_HELP.document(currentId).collection("ongoing_need").document(helpId).setData(data, completion: completion)
        
    }
}

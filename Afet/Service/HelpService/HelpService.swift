//
//  HelpService.swift
//  Afet
//
//  Created by Baris on 1.06.2023.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

class HelpService {
    
    let db = Firestore.firestore()
    
    static private var helps = [Help]()
    static private let helpId = NSUUID().uuidString

    static func addHelp(name: String, phone: String, need: String, piece: String, completion: @escaping (Error?) -> Void) {
        guard let currentId = Auth.auth().currentUser?.uid else {return}
        
        let helpId = NSUUID().uuidString
        
        let data = [
            "name" : name,
            "phone": phone,
            "need" : need,
            "piece": piece,
            "helpId" : helpId,
            "timestamp" : Timestamp(date: Date())
        ] as [String: Any]
        
        COLLECTION_HELP.document(currentId).collection("ongoing_need").document(helpId).setData(data, completion: completion)
    }
    
    
    static func getHelp(name: String, phone: String, tc: String,need: String, completion: @escaping (Error?) -> Void) {
        guard let currentId = Auth.auth().currentUser?.uid else {return}
        
        
        let data = [
            "name" : name,
            "phone": phone,
            "tc" : tc,
            "need" : need,
            "helpId" : helpId,
            "timestamp" : Timestamp(date: Date())
        ] as [String: Any]
        
        COLLECTION_HELP.document(currentId).collection("ongoing_help_need").document(helpId).setData(data, completion: completion)
    }
    
    
    
    //fetch
    static func fetchHelp(uid: String,completion: @escaping([Help])-> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}

        COLLECTION_HELP.document(uid).collection("ongoing_need").addSnapshotListener { snaphot, error in
            helps = []
            if let documents = snaphot?.documents{
                for doc in documents{
                    let data = doc.data()
                    helps.append(Help(data: data))
                    completion(helps)
                }
            }
        }
      
    }
}

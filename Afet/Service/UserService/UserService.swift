//
//  UserService.swift
//  Afet
//
//  Created by Baris on 2.06.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
struct UserService {
    static func fetchUser(uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot , error in
            guard let data = snapshot?.data() else {return}
            let user = User(data: data)
            completion(user)
        }
    }
}

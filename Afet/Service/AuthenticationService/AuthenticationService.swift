//
//  AuthenticationService.swift
//  Afet
//
//  Created by Baris on 31.05.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct IAuthenticationService{
    let emailText : String
    let passwordText: String
    let nameText: String
    let surnameText: String
}

final class AuthenticationService {
    
    // login
    static func login(email: String, password: String, completion: @escaping(AuthDataResult?, Error?)-> Void){
        Auth.auth().signIn(withEmail: email, password: password,completion: completion)
    }
    
    // register
    static func createUser(user: IAuthenticationService, completion: @escaping(Error?)->Void) {
        
          
                Auth.auth().createUser(withEmail: user.emailText, password: user.passwordText) { result, error in
                    guard let uid = result?.user.uid else {return}
                    let data = [
                        "email": user.emailText,
                        "name" : user.nameText,
                        "surname": user.surnameText,
                        "mail": user.passwordText,
                        "uid": uid
                    ] as [String : Any]
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
            }
        }
        
    


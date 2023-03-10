//
//  SignUpViewModel.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 9.03.2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol SignUpDelegate: AnyObject {
    var username: String {get}
    var mail: String {get}
    var password: String {get}
}

protocol SignUpViewModelProtocol {
    func signUp() -> Void
}

final class SignUpViewModel {
    weak var delegate: SignUpDelegate?
}

extension SignUpViewModel: SignUpViewModelProtocol {
    func signUp() {
        guard let mail = delegate?.mail, mail.count > 0 else {return}
        guard let password = delegate?.password, password.count > 0 else {return}
        Auth.auth().createUser(withEmail: mail, password: password) { result, error in
            if let signUpError = error {
                print(signUpError.localizedDescription)
                return
            }
            self.addUserDatabase(result)
        }
    }
    
    private func addUserDatabase(_ result: AuthDataResult?) {
        guard let userUID = result?.user.uid else {return}
        guard let username = delegate?.username else {return}
        
        let databaseRef = Database.database().reference()
        let usernameQuery = databaseRef.child("users").queryOrdered(byChild: "username").queryEqual(toValue: username)
        
        usernameQuery.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                print("Error: Username already exists")
            }
            else {
                let data = ["username" : username]
                let usersRef = databaseRef.child("users/\(userUID)")
                usersRef.setValue(data)
            }
        }
    }
}

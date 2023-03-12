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
    func failedSingUp(title: String, message: String)
}

protocol SignUpViewModelProtocol {
    func signUp(user: User) -> Void
}

final class SignUpViewModel {
    weak var delegate: SignUpDelegate?
}

extension SignUpViewModel: SignUpViewModelProtocol {
    func signUp(user: User) {
        let mail = user.email
        let password = user.password
        guard let username = user.username else {return}
        
        checkUsernameIsUnique(username) { isUnique in
            if isUnique {
                Auth.auth().createUser(withEmail: mail, password: password) { result, error in
                    if let signUpError = error {
                        print(signUpError.localizedDescription)
                        return
                    }
                    self.addUserDatabase(result, username: username)
                }
            }
        }
    }
    
    private func addUserDatabase(_ result: AuthDataResult?, username: String) {
        guard let userUID = result?.user.uid else {return}
        
        let databaseRef = Database.database().reference()
        let data = ["username" : username]
        let usersRef = databaseRef.child("users/\(userUID)")
        usersRef.setValue(data)
    }
    
    private func checkUsernameIsUnique(_ username: String, completion: @escaping (Bool) -> Void) {
        let databaseRef = Database.database().reference()
        let usernameQuery = databaseRef.child("users").queryOrdered(byChild: "username").queryEqual(toValue: username)
        
        usernameQuery.observeSingleEvent(of: .value) { snapshotUsername in
            if snapshotUsername.exists() {
                completion(false)
                return
            }
            completion(true)
        }
    }
}


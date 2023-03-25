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
    func alertSingUp(title: String, message: String)
}

protocol SignUpViewModelProtocol {
    func signUp(user: User) -> Void
    func addUserDatabase(username: String) -> Void
    func checkUsernameIsUnique(_ username: String, completion: @escaping (Bool) -> Void) -> Void
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
                Auth.auth().createUser(withEmail: mail, password: password) { [weak self] result, error in
                    if let signUpError = error {
                        print(signUpError.localizedDescription)
                        return
                    }
                    self?.addUserDatabase(username: username)
                    self?.delegate?.alertSingUp(title: "Successfully Registered", message: "You have successfully registered for the app")
                }
            }
        }
    }
    
    func addUserDatabase(username: String) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }

        let databaseRef = Database.database().reference()
        let data = ["username" : username]
        let usersRef = databaseRef.child("users/\(userUID)")
        usersRef.setValue(data)
    }
    
    func checkUsernameIsUnique(_ username: String, completion: @escaping (Bool) -> Void) {
        let databaseRef = Database.database().reference()
        let usernameQuery = databaseRef.child("users").queryOrdered(byChild: "username").queryEqual(toValue: username)
        
        usernameQuery.observeSingleEvent(of: .value) { [weak self] snapshotUsername in
            if snapshotUsername.exists() {
                completion(false)
                self?.delegate?.alertSingUp(title: "Invalid Username", message: "This username was taken before")
                return
            }
            completion(true)
        }
    }
}


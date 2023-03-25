//
//  LoginViewModel.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 9.03.2023.
//

import Foundation
import FirebaseAuth

protocol LoginDelegate: AnyObject {
    func succesfullyLogin()
    func failedLogin(title: String, message: String)
}

protocol LoginViewModelProtocol {
    func login(user: User) -> Void
}

final class LoginViewModel {
    weak var delegate: LoginDelegate?
}

extension LoginViewModel: LoginViewModelProtocol {
    func login(user: User) {
        let mail = user.email
        let password = user.password
        
        Auth.auth().signIn(withEmail: mail, password: password) { dataResult , dataError in
            if let error = dataError {
                print(error.localizedDescription)
                self.delegate?.failedLogin(title: "Login Failed", message: "You have entered an invalid email or password.")
                return
            }
            
            if dataResult != nil {
                    self.delegate?.succesfullyLogin()
            }
        }
    }
    
}

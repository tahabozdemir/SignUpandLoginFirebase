//
//  LoginViewModel.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 9.03.2023.
//

import Foundation
import FirebaseAuth

protocol LoginDelegate: AnyObject {
    var mail: String {get}
    var password: String {get}
}

protocol LoginViewModelProtocol {
    func login() -> Void
}

final class LoginViewModel {
    weak var delegate: LoginDelegate?
}

extension LoginViewModel: LoginViewModelProtocol {
    func login() {
        print("Login")
    }
    
}

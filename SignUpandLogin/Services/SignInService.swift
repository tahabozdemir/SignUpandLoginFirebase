//
//  GoogleSingInService.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 12.03.2023.
//

import Foundation
import Firebase
import GoogleSignIn

protocol SignInServiceProtocol {
    func signInApple()
    func signInGoogle(viewController: UIViewController, completion: @escaping (() -> Void))
    func signInFacebook()
}

class SignInService: SignInServiceProtocol {
    func signInGoogle(viewController: UIViewController, completion: @escaping (() -> Void)) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            if let errorSignIn  = error {
                print(errorSignIn.localizedDescription)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {return}
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                if let errorSignIn = error {
                    print(errorSignIn.localizedDescription)
                    return
                }
                completion()
            }
        }
    }
    
    func signInApple() {
        
    }
    
    func signInFacebook() {
        
    }
}

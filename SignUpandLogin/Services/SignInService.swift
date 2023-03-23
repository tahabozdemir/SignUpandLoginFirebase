//
//  GoogleSingInService.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 12.03.2023.
//

import Foundation
import Firebase
import GoogleSignIn

protocol SignInServiceDelegate: AnyObject {
    func signInFirst()
    func signInBefore()
}

protocol SignInServiceProtocol {
    func signInApple()
    func signInGoogle(viewController: UIViewController)
    func signInFacebook()
}

class SignInService {
    private let usersRef = Database.database().reference().child("users")
    weak var delegate: SignInServiceDelegate?
    
    func checkForExistingUsername() -> Void {
        guard let currentUser = Auth.auth().currentUser else {return}
        usersRef.child(currentUser.uid).observeSingleEvent(of: .value) {[weak self] snapshot in
            if let userData = snapshot.value as? [String: Any],
               let _ = userData["username"] as? String {
                self?.delegate?.signInBefore()
            } else {
                self?.delegate?.signInFirst()
            }
        }
    }
}

extension SignInService: SignInServiceProtocol {
    func signInGoogle(viewController: UIViewController) {
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
            
            Auth.auth().signIn(with: credential) {[weak self] result, error in
                if let errorSignIn = error {
                    print(errorSignIn.localizedDescription)
                    return
                }
                self?.checkForExistingUsername()
            }
        }
    }
    
    func signInApple() {
        
    }
    
    func signInFacebook() {
        
    }
}

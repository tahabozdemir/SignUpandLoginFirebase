//
//  UserNameRegisterViewController.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 22.03.2023.
//

import UIKit

class UserNameRegisterViewController: UIViewController {
    let viewModelSignUp = SignUpViewModel()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter a username"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()
    private let userNameTextField = BaseTextField(placeHolder: "Username", symbolName: "person", isSecureText: false)
    
    private let logoutButton: MainUIButton = {
        let button = MainUIButton("Logout")
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let forwardButton: MainUIButton = {
        let button = MainUIButton("Forward")
        button.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func logoutButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func forwardButtonTapped() {
        guard let username = userNameTextField.text else {return}
        viewModelSignUp.checkUsernameIsUnique(username) { [weak self] isUnique in
            if isUnique {
                self?.viewModelSignUp.addUserDatabase(username: username)
                let homeViewController = HomeViewController()
                homeViewController.modalPresentationStyle = .fullScreen
                homeViewController.modalTransitionStyle = .crossDissolve
                
                self?.dismiss(animated: false)
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.present(homeViewController, animated: true)
                }
                
            } else {
                let alert = UIAlertController(title: "Taken Username", message: "This Username Taken Before", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(alertAction)
                self?.present(alert, animated: true)
            }
        }
    }
    
    private func setupConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(30)
            make.centerX.equalTo(view)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view).inset(30)
            make.height.equalTo(55)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(forwardButton.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view).inset(30)
            make.height.equalTo(55)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(welcomeLabel)
        view.addSubview(userNameTextField)
        view.addSubview(logoutButton)
        view.addSubview(forwardButton)
    }
    
    override func viewDidLayoutSubviews() {
        setupConstraints()
    }
}

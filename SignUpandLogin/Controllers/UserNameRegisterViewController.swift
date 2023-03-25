//
//  UserNameRegisterViewController.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 22.03.2023.
//

import UIKit

class UserNameRegisterViewController: UIViewController {
    let viewModelSignUp = SignUpViewModel()
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Username"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()
    private let userNameTextField = BaseTextField(placeHolder: "Username", symbolName: "person", isSecureText: false)
    
    private let backButton: UIButton = {
        let button = UIButton()
        let mediumConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
        let backImage = UIImage(systemName: "arrowshape.backward", withConfiguration: mediumConfig)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        button.setImage(backImage, for: .normal)
        button.tintColor = .mainColor
        return button
    }()
    
    private let forwardButton: MainUIButton = {
        let button = MainUIButton("Next")
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
                DispatchQueue.main.async {
                    let homeViewController = HomeViewController()
                    homeViewController.modalPresentationStyle = .fullScreen
                    homeViewController.modalTransitionStyle = .crossDissolve
                    self?.dismiss(animated: false)
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        window.rootViewController?.present(homeViewController, animated: true)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Taken Username", message: "This Username Taken Before", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel)
                    alert.addAction(alertAction)
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    private func setupConstraints() {
        registerLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(30)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(registerLabel.snp.bottom).offset(30)
            make.width.equalTo(view).inset(30)
            make.centerX.equalTo(view)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(40)
            make.centerX.equalTo(view)
            make.width.equalTo(view).inset(30)
            make.height.equalTo(55)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view).offset(30)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(registerLabel)
        view.addSubview(userNameTextField)
        view.addSubview(backButton)
        view.addSubview(forwardButton)
    }
    
    override func viewDidLayoutSubviews() {
        setupConstraints()
    }
}

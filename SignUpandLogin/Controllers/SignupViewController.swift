//
//  ViewController.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 2.03.2023.
//

import UIKit
import SnapKit

class SingupViewController: UIViewController {

    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()
    
    let nickNameTextField = BaseTextField(placeHolder: "Nickname", symbolName: "person", isSecureText: false)
    let emailTextField = BaseTextField(placeHolder: "Email", symbolName: "envelope", isSecureText: false)
    let passwordTextField = BaseTextField(placeHolder: "Password", symbolName: "key.horizontal", isSecureText: true)
    
    var signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 60
        return stackView
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        let buttonFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        let buttonAttributes = [NSAttributedString.Key.font: buttonFont]
        button.setAttributedTitle(NSAttributedString(string: "Sign Up", attributes: buttonAttributes), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    let signUpWithLabel: UILabel = {
        let label = UILabel()
        label.text = "Or sign up with..."
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    let signUpWithStackView = LoginWithUIStackView()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Do you already have an account?"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        let buttonFont = UIFont.systemFont(ofSize: 15, weight: .bold)
        let buttonAttributes = [NSAttributedString.Key.font: buttonFont]
        button.addTarget(self, action:#selector(goToSignUpViewController), for: .touchUpInside)
        button.setAttributedTitle(NSAttributedString(string: "Login", attributes: buttonAttributes), for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        return button
    }()
    
    let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    
    @objc func goToSignUpViewController() {
        dismiss(animated: true)
    }
    
    func setupStackViews() {
        signUpStackView.addArrangedSubview(nickNameTextField)
        signUpStackView.addArrangedSubview(emailTextField)
        signUpStackView.addArrangedSubview(passwordTextField)
        
        loginStackView.addArrangedSubview(loginLabel)
        loginStackView.addArrangedSubview(loginButton)
    }
    
    func setupConstarints() {
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.equalTo(view.snp.leading).offset(30)
        }
        
        signUpStackView.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(40)
            make.width.equalTo(view).inset(30)
            make.centerX.equalTo(view)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signUpStackView.snp.bottom).offset(40)
            make.width.equalTo(view).inset(30)
            make.height.equalTo(55)
            make.centerX.equalTo(view)
        }
        
        signUpWithLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(40)
            make.centerX.equalTo(view)
        }
        
        signUpWithStackView.snp.makeConstraints { make in
            make.top.equalTo(signUpWithLabel.snp.bottom).offset(40)
            make.width.equalTo(view).inset(30)
            make.centerX.equalTo(view)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(signUpLabel)
        view.addSubview(signUpStackView)
        view.addSubview(signUpButton)
        view.addSubview(signUpWithLabel)
        view.addSubview(signUpWithStackView)
        view.addSubview(loginStackView)
    }
    
    override func viewDidLayoutSubviews() {
        setupConstarints()
        setupStackViews()
    }
}


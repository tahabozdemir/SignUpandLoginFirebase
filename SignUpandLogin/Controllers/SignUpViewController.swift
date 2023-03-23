//
//  SignUpViewController.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 2.03.2023.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    let viewModelSignUp = SignUpViewModel()
    
    private var user: User {
        let username = userNameTextField.text ?? ""
        let mail = emailTextField.text  ?? ""
        let password = passwordTextField.text ??  ""
        let user = User(username: username, email: mail, password: password)
        return user
    }
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()
    
    private let userNameTextField = BaseTextField(placeHolder: "Username", symbolName: "person", isSecureText: false)
    private let emailTextField = BaseTextField(placeHolder: "Email", symbolName: "envelope", isSecureText: false)
    private let passwordTextField = BaseTextField(placeHolder: "Password", symbolName: "key.horizontal", isSecureText: true)

    private var signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 60
        return stackView
    }()
    
    private let signUpButton: MainUIButton = {
        let button = MainUIButton("Sign Up")
        button.addTarget(self, action:#selector(singUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Do you already have an account?"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        let buttonFont = UIFont.systemFont(ofSize: 15, weight: .bold)
        let buttonAttributes = [NSAttributedString.Key.font: buttonFont]
        button.addTarget(self, action:#selector(goSignUpViewController), for: .touchUpInside)
        button.setAttributedTitle(NSAttributedString(string: "Login", attributes: buttonAttributes), for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        return button
    }()
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    @objc func goSignUpViewController() {
        dismiss(animated: true)
    }
    
    @objc func singUpButtonTapped() {
        let usernameIsEmpty = user.username?.isEmpty != true
        let mailIsEmpty = user.email.isEmpty != true
        let passwordIsEmpty = user.password.isEmpty != true
        
        let isFormValid = usernameIsEmpty && mailIsEmpty && passwordIsEmpty
        
        if isFormValid {
            viewModelSignUp.signUp(user: user)
        }
        
        else if !isFormValid {
            failedSingUp(title: "There Is Empty Field", message: "Please fill in the empty fields")
        }
    }
    
    func setupStackViews() {
        signUpStackView.addArrangedSubview(userNameTextField)
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
        
        loginStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelSignUp.delegate = self
        view.backgroundColor = .white
        view.addSubview(signUpLabel)
        view.addSubview(signUpStackView)
        view.addSubview(signUpButton)
        view.addSubview(loginStackView)
    }
    
    override func viewDidLayoutSubviews() {
        setupConstarints()
        setupStackViews()
    }
}

extension SignUpViewController: SignUpDelegate {
    func failedSingUp(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}

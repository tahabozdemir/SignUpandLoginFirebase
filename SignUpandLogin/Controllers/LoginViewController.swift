//
//  LoginViewController.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 8.03.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    let viewModelLogin = LoginViewModel()
    
    private let imageViewLogin: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()
    
    private let emailTextField = BaseTextField(placeHolder: "Email", symbolName: "envelope", isSecureText: false)
    let passwordTextField = BaseTextField(placeHolder: "Password", symbolName: "key.horizontal", isSecureText: true)
    
    private var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 60
        return stackView
    }()
    
    private let loginButton: MainUIButton = {
        let button = MainUIButton("Login")
        return button
    }()
    
    private let loginWithLabel: UILabel = {
        let label = UILabel()
        label.text = "Or login with..."
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let loginWithStackView = LoginWithUIStackView()
    
    let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "New to CompanyName?"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        let buttonFont = UIFont.systemFont(ofSize: 15, weight: .bold)
        let buttonAttributes = [NSAttributedString.Key.font: buttonFont]
        button.addTarget(self, action:#selector(goToLoginViewController), for: .touchUpInside)
        button.setAttributedTitle(NSAttributedString(string: "Register", attributes: buttonAttributes), for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        return button
    }()
    
    private let registerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    
    @objc func goToLoginViewController() {
        let signUpViewController = SingupViewController()
        signUpViewController.modalPresentationStyle = .fullScreen
        present(signUpViewController, animated: true)
    }
    
    func setupStackViews() {
        loginStackView.addArrangedSubview(emailTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        
        registerStackView.addArrangedSubview(registerLabel)
        registerStackView.addArrangedSubview(registerButton)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - (view.frame.height) * 0.1)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func setupConstarints() {
        imageViewLogin.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(view).multipliedBy(0.25)
            make.centerX.equalTo(view)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(imageViewLogin.snp.bottom).offset(40)
            make.leading.equalTo(view.snp.leading).offset(30)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(40)
            make.width.equalTo(view).inset(30)
            make.centerX.equalTo(view)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(loginStackView.snp.bottom).offset(40)
            make.width.equalTo(view).inset(30)
            make.height.equalTo(55)
            make.centerX.equalTo(view)
        }
        
        loginWithLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(40)
            make.centerX.equalTo(view)
        }
        
        loginWithStackView.snp.makeConstraints { make in
            make.top.equalTo(loginWithLabel.snp.bottom).offset(40)
            make.width.equalTo(view).inset(30)
            make.centerX.equalTo(view)
        }
        
        registerStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelLogin.delegate = self
        view.addSubview(imageViewLogin)
        view.addSubview(loginLabel)
        view.addSubview(loginStackView)
        view.addSubview(loginButton)
        view.addSubview(loginWithLabel)
        view.addSubview(loginWithStackView)
        view.addSubview(registerStackView)
    }
    
    override func viewDidLayoutSubviews() {
        setupConstarints()
        setupStackViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension LoginViewController: LoginDelegate {
    var mail: String {
        guard let mail = emailTextField.text else {return ""}
        return mail
    }
    
    var password: String {
        guard let password = passwordTextField.text else {return ""}
        return password
    }
}

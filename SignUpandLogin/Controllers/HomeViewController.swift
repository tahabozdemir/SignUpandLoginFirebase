//
//  HomeViewController.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 11.03.2023.
//

import UIKit
import SnapKit
import Firebase

class HomeViewController: UIViewController {
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()
    
    private let logoutButton: MainUIButton = {
        let button = MainUIButton("Logout")
        button.addTarget(HomeViewController.self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private func setupConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view).inset(30)
            make.height.equalTo(55)
        }
    }
    
    @objc func logoutButtonTapped() {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(welcomeLabel)
        view.addSubview(logoutButton)
        welcomeLabel.text  = Auth.auth().currentUser?.uid
    }
    
    override func viewDidLayoutSubviews() {
        setupConstraints()
    }
}

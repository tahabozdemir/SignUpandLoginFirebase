//
//  HomeViewController.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 11.03.2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to App"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()
    
    let logoutButton = MainUIButton("Logout")
    
    func setupConstraints() {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(welcomeLabel)
        view.addSubview(logoutButton)
    }
    
    override func viewDidLayoutSubviews() {
        setupConstraints()
    }
}

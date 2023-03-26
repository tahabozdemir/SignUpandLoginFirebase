//
//  PasswordTextField.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 26.03.2023.
//

import UIKit
import SnapKit

final class PasswordTextField: BaseTextField {
    private var isEyeButtonTapped: Bool = false
    
    private let eyeButton: UIButton = {
        let button = UIButton()
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .medium)
        let image = UIImage(systemName: "eye.slash", withConfiguration: imageConfiguration)
        button.tintColor = .gray
        button.setImage(image, for: .normal)
        button.addTarget(self, action:#selector(eyeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func eyeButtonTapped() {
        let imageEyeSlash = UIImage(systemName: "eye.slash")
        let imageEye = UIImage(systemName: "eye")
        
        if isEyeButtonTapped {
            eyeButton.setImage(imageEyeSlash, for: .normal)
            isEyeButtonTapped = false
            self.isSecureTextEntry = true
        }
        
        else {
            eyeButton.setImage(imageEye, for: .normal)
            isEyeButtonTapped = true
            self.isSecureTextEntry = false
        }
    }
    
    private func setupConstraints() {
        eyeButton.snp.makeConstraints { make in
            make.trailing.equalTo(self)
        }
    }
    
    init() {
        super.init(placeHolder: "Password", symbolName: "key.horizontal", isSecureText: true)
        addSubview(eyeButton)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

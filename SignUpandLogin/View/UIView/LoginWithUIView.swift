//
//  LoginWithUIButton.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 8.03.2023.
//

import UIKit
import SnapKit

class LoginWithUIView: UIView {
    let loginWithUIImageView  = UIImageView()
    
    func setupConstraint() {
        self.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(55)
        }
        
        loginWithUIImageView.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.center.equalTo(self)
        }
    }
    
    init(imageName: String) {
        super.init(frame: CGRect.zero)
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        
        loginWithUIImageView.image = UIImage(named: imageName)
        addSubview(loginWithUIImageView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddSubview(_ subview: UIView) {
        setupConstraint()
    }
    
}

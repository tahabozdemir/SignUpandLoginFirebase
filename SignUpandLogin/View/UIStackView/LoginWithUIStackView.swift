//
//  LoginWithStackView.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 8.03.2023.
//

import UIKit
import SnapKit

class LoginWithUIStackView: UIStackView {
    func setupConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    
    let facebookUIView = LoginWithUIView(imageName: "facebook")
    let googleUIView = LoginWithUIView(imageName: "google")
    let appleUIView = LoginWithUIView(imageName: "apple")
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        
        addArrangedSubview(googleUIView)
        addArrangedSubview(facebookUIView)
        addArrangedSubview(appleUIView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddSubview(_ subview: UIView) {
        setupConstraints()
    }
}

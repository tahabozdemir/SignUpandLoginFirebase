//
//  MainUIButton.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 11.03.2023.
//

import UIKit

class MainUIButton: UIButton {
    init(_ title: String) {
        super.init(frame: CGRect.zero)
        let buttonFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        let buttonAttributes = [NSAttributedString.Key.font: buttonFont]
        setAttributedTitle(NSAttributedString(string: title, attributes: buttonAttributes), for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .mainColor
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

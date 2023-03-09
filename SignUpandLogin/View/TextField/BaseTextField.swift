//
//  BaseTextField.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 8.03.2023.
//

import UIKit
import SnapKit


class BaseTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    @objc func doneButtonTapped() {
        self.resignFirstResponder()
    }
    
    func setupToolBar() {
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: UIScreen.main.bounds.width, height: 30))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonTapped))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    public func addBottomLineTextField() {
        let bottomLineTextField = UIView()
        addSubview(bottomLineTextField)
        bottomLineTextField.backgroundColor = .lightGray
        bottomLineTextField.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(20)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(0.5)
        }
    }
    
    public func addSymbolTextField(_ symbolName: String) {
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: symbolName, withConfiguration: imageConfiguration)
        let imageView = UIImageView()
        imageView.tintColor = .gray
        imageView.image = image
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(self)
        }
    }
    
    init(placeHolder: String?=nil, symbolName: String, isSecureText: Bool) {
        super.init(frame: CGRect.zero)
        let placeHolderAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        font = UIFont.systemFont(ofSize: 15, weight: .regular)
        returnKeyType = .continue
        isSecureTextEntry = isSecureText
        attributedPlaceholder = NSAttributedString(string: placeHolder ?? "", attributes: placeHolderAttributes)
        
        autocorrectionType = .no
        autocapitalizationType = .none
        enablesReturnKeyAutomatically = true
        
        tintColor = .black
        textColor = .tintColor
        
        addBottomLineTextField()
        addSymbolTextField(symbolName)
        setupToolBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddSubview(_ subview: UIView) {
        
    }
}

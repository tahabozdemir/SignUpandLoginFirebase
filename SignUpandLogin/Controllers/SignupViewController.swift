//
//  ViewController.swift
//  SignUpandLogin
//
//  Created by Taha Bozdemir on 2.03.2023.
//

import UIKit
import SnapKit

class SingupViewController: UIViewController {
    let imageViewSingup: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "singup")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    func setupConstarints() {
        imageViewSingup.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.5)
            make.height.equalTo(view).multipliedBy(0.2)
            make.center.equalTo(view)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupConstarints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageViewSingup)
    }
}


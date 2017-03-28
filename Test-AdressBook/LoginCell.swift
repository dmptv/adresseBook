//
//  LoginCell.swift
//  Test-AdressBook
//
//  Created by Kanat A on 28/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "iconlogo")
        return iv
    }()
    
    let loginTextfield: LeftPaddingTextfield = {
        let tf = LeftPaddingTextfield()
        tf.placeholder = "Enter login"
        //tf.keyboardType = .emailAddress
        tf.textColor = .white
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let passwordTextfield: LeftPaddingTextfield = {
        let tf = LeftPaddingTextfield()
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        return tf
    }()
    
    lazy var  loginButton: UIButton = {
        let lb = UIButton()
        lb.backgroundColor = UIColor(red: 122/255, green: 83/255, blue: 206/255, alpha: 1)
        lb.setTitle("Log in", for: .normal)
        lb.setTitleColor(.white, for: .normal)
        lb.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return lb
    }()
    
    weak var delegate: LoginControllerDelegate?
    
    func handleLogin() {
        guard let login = loginTextfield.text, let password = passwordTextfield.text else {return}
        
        ApiService.shared.fetchAutorization(login: login, password: password) { (successe) in
            print(successe)
            UserDefaults.standard.setIsLoggedIn(value: successe)
            self.delegate?.finishLoggingIn()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        addSubview(loginTextfield)
        addSubview(passwordTextfield)
        addSubview(loginButton)
        
        _ = logoImageView.anchor(top: centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        
        _ = loginTextfield.anchor(top: logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = passwordTextfield.anchor(top: loginTextfield.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = loginButton.anchor(top: passwordTextfield.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class  LeftPaddingTextfield: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
    }
    
}



























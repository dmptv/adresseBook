//
//  EmployeesCell.swift
//  Test-AdressBook
//
//  Created by Kanat A on 30/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit
import SDWebImage

 let blueColor = UIColor(r: 61, g: 167, b: 244)

class EmployeesCell: BaseCell {
    var employer: Employer? {
        didSet {
            if let employer = employer, let id = employer.ID, let ID = Int(id) {
                nameLabel.text = employer.Name
                titleLabel.text = employer.Title
   
                let loginPassword = UserDefaults.standard.getLoginPassword()
                guard let login = loginPassword.login, let password = loginPassword.password else {return}
                let urlString = "https://contact.taxsee.com/Contacts.svc/GetWPhoto?login=\(login)&password=\(password)&id=\(ID)"
                guard let url = URL(string: urlString) else {return}
                profileImageView.sd_setImage(with: url)
                
                self.setNeedsDisplay()
            }
        }
    }
 
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Georgia-Bold", size: 16)
        return lb
    }()
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14)
        lb.numberOfLines = 2
        return lb
    }()

    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(titleLabel)
        addSubview(dividerLineView)

        setConstraints()
    }
}

class EmployeesHeader: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(dividerLineView)
        
        _ = nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = dividerLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



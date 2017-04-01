//
//  EmployeesCell + Constraints.swift
//  Test-AdressBook
//
//  Created by Kanat A on 31/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

extension EmployeesCell {
    
    func setConstraints() {
        _ = profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        _ = nameLabel.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: -2, leftConstant: 12, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 20)
        
        _ = titleLabel.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 34)
        
        _ = dividerLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
}

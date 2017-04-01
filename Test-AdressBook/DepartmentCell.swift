//
//  DepartmentCell.swift
//  Test-AdressBook
//
//  Created by Kanat A on 29/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class DepartmentCell: BaseCell {

    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "IT офис"
        label.textAlignment = .center
        label.font = UIFont(name: "Georgia-Bold", size: 16)
        label.textColor = .white
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(dividerLineView)
        
        _ = nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = dividerLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 1)
    }
}
























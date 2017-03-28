//
//  PageCell.swift
//  Test-AdressBook
//
//  Created by Kanat A on 27/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    var page: Page? {
        didSet {
            guard let page = page else {
                return
            }
            
            imageView.image = UIImage(named: page.imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            let attributedtext = NSMutableAttributedString(string: page.title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium), NSForegroundColorAttributeName: color])
            
            attributedtext.append(NSMutableAttributedString(string: "\n\n\(page.message)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedtext.string.characters.count
            attributedtext.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSRange.init(location: 0, length: length))
            
            textView.attributedText = attributedtext
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.layer.masksToBounds = true 
        iv.image = UIImage(named: "book-green")
        iv.backgroundColor = .green
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "temporary content text"
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        tv.isSelectable = false
        tv.isEditable = false
        tv.backgroundColor = UIColor(red: 122/255, green: 83/255, blue: 115/255, alpha: 1)
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
    _ = imageView.anchor(top: topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    
    _ = textView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 20, rightConstant: 16, widthConstant: 0, heightConstant: 0)
    textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    
    _ = lineSeparatorView.anchor(top: nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}














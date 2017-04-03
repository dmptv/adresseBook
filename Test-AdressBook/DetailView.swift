//
//  DetailView.swift
//  Test-AdressBook
//
//  Created by Kanat A on 31/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit
import MessageUI

class DetailLauncher: NSObject, MFMailComposeViewControllerDelegate {
    
    weak var employeesController: EmployeesController?
    weak var bureauController: BureauController?
        
    let cellID = "cellID"
    let blackView = UIView()
    
    var employer: Employer? {
        didSet {
            if let employer = employer, let id = employer.ID, let ID = Int(id) {
                nameLabel.text = employer.Name
                titleLabel.text = employer.Title
                emailButton.setTitle(employer.Email, for: .normal)
                phoneButton.setTitle(employer.Phone, for: .normal)
                
                let loginPassword = UserDefaults.standard.getLoginPassword()
                guard let login = loginPassword.login, let password = loginPassword.password else {return}
                let urlString = "https://contact.taxsee.com/Contacts.svc/GetWPhoto?login=\(login)&password=\(password)&id=\(ID)"
                guard let url = URL(string: urlString) else {return}
                profileImageView.sd_setImage(with: url)
                
                blackView.setNeedsDisplay()
            }
        }
    }
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(brounColor, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2)
        button.layer.cornerRadius = 5
        button.layer.borderColor = brounColor.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    let profileImageView: SLImageView = {
        let iv = SLImageView(frame: .zero)
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
    
    let emailLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Email:"
        lb.font = .systemFont(ofSize: 14)
        lb.numberOfLines = 2
        return lb
    }()
    
    let phoneLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Phone:"
        lb.font = .systemFont(ofSize: 14)
        lb.numberOfLines = 2
        return lb
    }()
    
    let emailButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(blueColor, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2)
        button.layer.cornerRadius = 5
        button.layer.borderColor = blueColor.cgColor
        button.layer.borderWidth = 1
        button.setImage( #imageLiteral(resourceName: "mail"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        return button
    }()

    let phoneButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(blueColor, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2)
        button.layer.cornerRadius = 5
        button.layer.borderColor = blueColor.cgColor
        button.layer.borderWidth = 1
        button.setImage( #imageLiteral(resourceName: "123"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        return button
    }()

    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = .white
            blackView.frame = CGRect(x: window.frame.width - 10, y: window.frame.height - 10, width: 10, height: 10)
            window.addSubview(blackView)
            setSubViews(superView: window)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.frame = window.frame
                
            }, completion: { (completedAnimation) in})
        }
    }
  
    func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.subviews.forEach({$0.removeFromSuperview()})
            let tempRect = self.blackView.frame
            self.blackView.frame = CGRect(x: tempRect.width - 10, y: tempRect.height - 10, width: 10, height: 10)
            self.blackView.layoutSubviews()
            
        }) { (completion: Bool) in
            self.blackView.removeFromSuperview()
        }
    }

}









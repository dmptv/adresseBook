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
    
    var employeesController: EmployeesController?
    var bureauController: BureauController?
   
    let cellID = "cellID"
    
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
    
    let blackView = UIView()
    
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
    
    func getResponderController() -> UIViewController? {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while topVC?.presentedViewController != nil {
            topVC = topVC!.presentedViewController
        }
        return topVC
    }
    
    func handleEmailSend() {
        let mailCompose = MFMailComposeViewController()
        mailCompose.mailComposeDelegate = self
        guard let text = emailButton.titleLabel?.text else {return}
        mailCompose.setToRecipients([text])
        mailCompose.setSubject("Test")
        mailCompose.setMessageBody("Hi", isHTML: false)
        
        if MFMailComposeViewController.canSendMail() {
            let topVC = getResponderController()
            topVC?.present(mailCompose, animated: true, completion: {
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.blackView.alpha = 0
                    
                }, completion: nil)
            })
            
        } else {
            let emailAlert = UIAlertController.init(title: "Email Alert", message: "can't send email", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
            emailAlert.addAction(action)
            
            let topVC = getResponderController()
            topVC?.present(emailAlert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("cancel mail")
        case MFMailComposeResult.saved.rawValue:
            print("saved mail")
        case MFMailComposeResult.failed.rawValue:
            print("faild send")
        case MFMailComposeResult.sent.rawValue:
            print("sent mail")
        default: break
        }
        
        let topVC = getResponderController()
        topVC?.dismiss(animated: true, completion: {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                self.blackView.layoutSubviews()
            }, completion: nil)
        })
     }
    
    func handlePhoneCall() {
        let url = URL(string: "tel://" + (phoneButton.titleLabel?.text)!)
        UIApplication.shared.openURL(url!)
        
        if let url = NSURL(string: "tel://\(phoneButton.titleLabel?.text)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    func setSubViews(superView: UIView) {
        
        blackView.addSubview(backButton)
        blackView.addSubview(profileImageView)
        blackView.addSubview(nameLabel)
        blackView.addSubview(titleLabel)
        blackView.addSubview(emailLabel)
        blackView.addSubview(phoneLabel)
        blackView.addSubview(emailButton)
        blackView.addSubview(phoneButton)
        
        _ = backButton.anchor(top: superView.topAnchor, left: superView.leftAnchor, bottom: nil, right: nil, topConstant: 26, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 70, heightConstant: 26)
        
        let height = (superView.frame.width - 12 - 12) * 9 / 16
        
        _ = profileImageView.anchor(top: backButton.bottomAnchor, left: superView.leftAnchor, bottom: nil, right: superView.rightAnchor, topConstant: 20, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: height)
        
        _ = nameLabel.anchor(top: profileImageView.bottomAnchor, left: profileImageView.leftAnchor, bottom: nil, right: profileImageView.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        _ = titleLabel.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 34)
        
        _ = emailLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 50, heightConstant: 20)
        
        _ = phoneLabel.anchor(top: emailLabel.bottomAnchor, left: emailLabel.leftAnchor, bottom: nil, right: nil, topConstant: 40, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 50, heightConstant: 20)
        
        _ = emailButton.anchor(top: emailLabel.topAnchor, left: emailLabel.rightAnchor, bottom: nil, right: titleLabel.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 26)
        
        _ = phoneButton.anchor(top: phoneLabel.topAnchor, left: emailButton.leftAnchor, bottom: nil, right: emailButton.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 26)
        
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        emailButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEmailSend)))
        phoneButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoneCall)))
    }


    
}









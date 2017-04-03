//
//  DetailLauncher + Constraints.swift
//  Test-AdressBook
//
//  Created by Kanat A on 02/04/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit
import MessageUI

extension DetailLauncher {
    
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
        
        backButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(handleEmailSend), for: .touchUpInside)
        phoneButton.addTarget(self, action: #selector(handlePhoneCall), for: .touchUpInside)
    }
  
    func handlePhoneCall() {
        let url = URL(string: "tel://" + (phoneButton.titleLabel?.text)!)
        UIApplication.shared.openURL(url!)
        
        if let url = NSURL(string: "tel://\(phoneButton.titleLabel?.text)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
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
            mailCompose.navigationBar.tintColor = brounColor
            let topVC = getResponderController()
            
            topVC?.present(mailCompose, animated: true, completion: {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.blackView.alpha = 0
                }, completion: nil)
            })
            
        } else {
            let topVC = getResponderController()
            let emailAlert = UIAlertController.init(title: "Email Alert", message: "can't send email", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
            emailAlert.addAction(action)
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
    
}






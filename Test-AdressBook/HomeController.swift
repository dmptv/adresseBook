//
//  HomeController.swift
//  Test-AdressBook
//
//  Created by Kanat A on 27/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        navigationItem.title = "Departments"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogout))
      
    }


    func handleLogout() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)

    }

}

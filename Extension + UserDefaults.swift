//
//  UserDefaults.swift
//  Test-AdressBook
//
//  Created by Kanat A on 28/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
        case kLogin
        case kPassword
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func saveLoginPassword(login: String, password: String) {
        set(login, forKey: UserDefaultsKeys.kLogin.rawValue)
        set(password, forKey: UserDefaultsKeys.kPassword.rawValue)
    }
    
    func getLoginPassword() -> LoginPassword {
        let login = string(forKey: UserDefaultsKeys.kLogin.rawValue)
        let password = string(forKey: UserDefaultsKeys.kPassword.rawValue)
        return LoginPassword(login: login, password: password)
    }
    
    
    
    
}

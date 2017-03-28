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
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    
}

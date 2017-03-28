//
//  ApiService.swift
//  Test-AdressBook
//
//  Created by Kanat A on 28/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let shared = ApiService()
    
    func fetchAutorization(login: String, password: String, completion: @escaping (Bool)->() ) {
        
        let login = login
        let password = password
        
        let url = URL(string: "https://contact.taxsee.com/Contacts.svc/Hello?login=\(login)&password=\(password)")

        URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            if error != nil {
                print("login or password is not valid")
            }
            
            do {
                guard let data = data else {return}
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
        
                
                if let success = json["Success"] as? Bool {
                    completion(success)
                }
 
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
        
    }
    

    
    
    
    
}

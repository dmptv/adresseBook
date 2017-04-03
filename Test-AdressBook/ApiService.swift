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
    
    // Fetch Data
    
    func fetchOffice(login: String, password: String, completion: @escaping (Officce)->() ) {
        
        guard let url = URL(string: "https://contact.taxsee.com/Contacts.svc/GetAll?login=\(login)&password=\(password)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if error != nil {
                print("data not valid")
                if let window = UIApplication.shared.keyWindow {
                    let label = UILabel()
                    label.text = "Data is not valid or problem with Internet Connection"
                    label.textColor = UIColor(r: 227, g: 184, b: 237)
                    label.numberOfLines = 2
                    label.frame = CGRect(x: 20, y: window.bounds.height / 2, width: window.bounds.width - 40, height: 50)
                    window.addSubview(label)
                    return
                }
            }
            
            do {
                guard let unwrappedData = data, let json = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String: Any] else {return}
                let office = Officce()
                office.Name = json["Name"] as! String?
                office.ID = json["ID"] as! String?
                office.Departments = json["Departments"] as! [Any]?
                
                DispatchQueue.main.async {
                    completion(office)
                }

            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }

    // Autorization
    
    func fetchAutorization(login: String, password: String, completion: @escaping (Bool)->() ) {
        
        guard let url = URL(string: "https://contact.taxsee.com/Contacts.svc/Hello?login=\(login)&password=\(password)") else {return}

        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if error != nil {
                print("login or password is not valid")
            }
            
            do {
                guard let unwrappedData = data else {return}
                let json = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as! [String: Any]
        
                if let success = json["Success"] as? Bool {
                    if success == true {
                        completion(success)
                    } else {
                        DispatchQueue.main.async {
                            completion(success)
                        }
                        
                    }
                   
                }
                
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
 
}



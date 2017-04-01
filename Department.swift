//
//  Departments.swift
//  Test-AdressBook
//
//  Created by Kanat A on 29/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class Department: NSObject {
    var ID: String?
    var Name: String?
    var Departments: [Any]?
    
}

class Officce: NSObject {
    var ID: String?
    var Name: String?
    var Employees: [Any]?
    var Departments: [Any]?
}

class Employer: NSObject {
    var ID: String?
    var Name: String?
    var Title: String?
    var Email: String?
    var Phone: String?
}

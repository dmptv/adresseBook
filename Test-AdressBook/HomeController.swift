//
//  HomeController.swift
//  Test-AdressBook
//
//  Created by Kanat A on 27/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

let brounColor = UIColor(r: 91, g: 14, b: 13)

class HomeController:  UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let cellId = "cellId"
    let refresher = UIRefreshControl()
    
    var dataSource = [Officce]()
    var office: Officce? {
        didSet {
            self.dataSource.removeAll()
            
            if let departmentsArray = office?.Departments {
                for dictionary in departmentsArray {
                    
                    let office = Officce()
                    office.Name = (dictionary as! [String : Any])["Name"] as! String?
                    office.ID =  (dictionary as! [String : Any])["ID"]  as! String?
                    office.Employees = (dictionary as! [String : Any])["Employees"] as! [Any]?
                    office.Departments = (dictionary as! [String : Any])["Departments"] as! [Any]?
                    
                    self.dataSource.append(office)
                }
            }

            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                        
        navigationItem.title = "Все"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.leftBarButtonItem?.tintColor = brounColor
        
        setupCollectionView()
        
        let loginPassword = UserDefaults.standard.getLoginPassword()
        guard let login = loginPassword.login, let password = loginPassword.password else {return}
        ApiService.shared.fetchOffice(login: login, password: password) { (office) in
            self.office = office
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func handleLogout() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    fileprivate func setupCollectionView() {
        refresher.tintColor = .red;
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionView?.addSubview(refresher)
        
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "papel")?.draw(in: view.bounds)
        if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            view.backgroundColor = UIColor(patternImage: image)
        }
        
        collectionView?.backgroundColor = .clear
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(DepartmentCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func loadData() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        refresher.endRefreshing()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DepartmentCell
        
        let office: Officce = dataSource[indexPath.item]
        if let text = office.Name {
            cell.nameLabel.text = text
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let office: Officce = dataSource[indexPath.item]
        
        if (office.Employees != nil) { // it ofice, test 3
            let layout = UICollectionViewFlowLayout()
            let employeesController = EmployeesController(collectionViewLayout: layout)
            employeesController.office = office
            
            navigationController?.pushViewController(employeesController, animated: true)
            
            
        } else if  (office.Employees == nil) && (office.Departments == nil) { // tets 1 + 2 грузина
            let layout = UICollectionViewFlowLayout()
            let bureauController = BureauController(collectionViewLayout: layout)
            bureauController.office = office
            
            navigationController?.pushViewController(bureauController, animated: true)

        } else {
            let layout = UICollectionViewFlowLayout()
            let aviaController = AviaController(collectionViewLayout: layout)
            aviaController.office = dataSource[indexPath.item]
                
            navigationController?.pushViewController(aviaController, animated: true)
        }
    }
}





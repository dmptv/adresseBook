//
//  AviaController.swift
//  Test-AdressBook
//
//  Created by Kanat A on 31/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AviaController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var dataSource = [Officce]()
    
    var office: Officce? {
        didSet {
            if let office = office {
                dataSource.removeAll()
                
                guard let array = office.Departments else {return}
                
                for dictionary in array {
                    let office = Officce()
                    office.setValuesForKeys(dictionary as! [String : Any])
                    dataSource.append(office)
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = office?.Name
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "papel")?.draw(in: view.bounds)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            view.backgroundColor = UIColor(patternImage: image)
        }
        
        collectionView?.backgroundColor = .clear
        collectionView?.alwaysBounceVertical = true
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        
        collectionView?.register(DepartmentCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DepartmentCell
        cell.nameLabel.text = dataSource[indexPath.item].Name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
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








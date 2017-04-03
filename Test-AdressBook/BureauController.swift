//
//  BureauController.swift
//  Test-AdressBook
//
//  Created by Kanat A on 30/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class BureauController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let employerId = "employerId"
    let headerId = "headerId"
    
    let refresher = UIRefreshControl()
    
    var dataSource = [Employer]()
    var office: Officce? {
        didSet {
            if let office = office {
                dataSource.removeAll()
                let employer = Employer()
                employer.Name = office.Name
                employer.ID = office.ID
                dataSource.append(employer)
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    lazy var detailLauncher: DetailLauncher = {
        let launcher = DetailLauncher()
        launcher.bureauController = self
        return launcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        refresher.tintColor = .red;
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionView?.addSubview(refresher)
        
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 200)
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(EmployeesCell.self, forCellWithReuseIdentifier: employerId)
         collectionView?.register(EmployeesHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: employerId, for: indexPath) as! EmployeesCell
        cell.employer = dataSource[indexPath.item]
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 25)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! EmployeesHeader
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detailLauncher.employer = dataSource[indexPath.item]
        detailLauncher.showSettings()
    }

 

}







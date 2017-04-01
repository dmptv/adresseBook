//
//  ViewController.swift
//  Test-AdressBook
//
//  Created by Kanat A on 27/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

protocol LoginControllerDelegate: class {
    func finishLoggingIn()
}

class LoginController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, LoginControllerDelegate {
    
    let cellId = "cellId"
    let loginCellId = "loginCell"
    
    //var office: Officce?
    
    let pages: [Page] = {
        let firstPage = Page(title: "Тестовое задание на разработку мобильного приложения.", message: "Требуется разработать приложение «Адресная Книга» сотрудников компании.", imageName: "AB")
 
        return [firstPage]
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(colorLiteralRed: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
        return button
    }()
    
    func skip() {
        pageControl.currentPage = pages.count - 1
        nextPage()
    }
    
    func nextPage() {
        if pageControl.currentPage == pages.count {return}
        
        if pageControl.currentPage == pages.count - 1 {
            moveControlConstraintsOffScreen()
            animateLayout()
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        pageControl.currentPage += 1
    }
    
    fileprivate func moveControlConstraintsOffScreen() {
        pageControlBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant = -40
    }
    
    func animateLayout() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 122/255, green: 83/255, blue: 115/255, alpha: 1)
        cv.isPagingEnabled = true 
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.numberOfPages = 2
        pc.currentPageIndicatorTintColor = UIColor(colorLiteralRed: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        return pc
    }()
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    
    // View Life Circle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        
        observeKeyBoardNotifications()
      
        _ = collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        pageControlBottomAnchor = pageControl.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
        
        skipButtonTopAnchor = skipButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        
        registerCells()
    }
    
    // KeyBoard
    
    fileprivate func  observeKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyBoardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -55
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    func keyBoardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }

    func registerCells() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    

    //MARK: - UICollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            loginCell.delegate = self
            
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        cell.page = pages[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    //MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
       
        if pageNumber == pages.count {
            moveControlConstraintsOffScreen()
        } else {
            pageControlBottomAnchor?.constant = 0
            skipButtonTopAnchor?.constant = 16
        }
        
        animateLayout()
    }
    
    //MARK: - LoginControllerDelegate
    
    func finishLoggingIn() {
        if UserDefaults.standard.isLoggedIn() {
            let rootController = UIApplication.shared.keyWindow?.rootViewController
            
            guard let mainNavController = rootController as? MainNavigationController  else {
                return
            }
            let layout = UICollectionViewFlowLayout()
            let homeController = HomeController(collectionViewLayout: layout)
            mainNavController.viewControllers = [homeController]
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }

}















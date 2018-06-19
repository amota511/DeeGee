//
//  MatchVotingVC.swift
//  DeeGee
//
//  Created by amota511 on 6/14/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit

class MatchVotingVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //@IBOutlet weak var matchesCV: UICollectionView!
    
    var matchesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        self.title = "Matches"
        self.view.backgroundColor = .white
        setRightBarButton()
        
//        matchesCV.register(MatchCVC.self, forCellWithReuseIdentifier: "matchCell")
//        matchesCV.backgroundColor = .green
//        
//        
//        let flowlayout = UICollectionViewFlowLayout()
//        flowlayout.itemSize = CGSize(width: 50, height: 50)
//        flowlayout.scrollDirection = .vertical
//        flowlayout.sectionInset = .init(top: 3, left: 3, bottom: 3, right: 3)
//        
//        matchesCV.setCollectionViewLayout(flowlayout, animated: true)
//        
        setupMatchCV()
        
    }
    
    func setupMatchCV() {
       
        let matchLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        matchLayout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        matchLayout.minimumInteritemSpacing = 0
        matchLayout.minimumLineSpacing = 2
        matchLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height * 0.45)
        matchLayout.scrollDirection = .vertical
        
        
        matchesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height ), collectionViewLayout: matchLayout)
        matchesCollectionView.dataSource = self
        matchesCollectionView.delegate = self
        matchesCollectionView.register(MatchCVC.self, forCellWithReuseIdentifier: "matchCell")
        matchesCollectionView.isScrollEnabled = true
        matchesCollectionView.backgroundColor = UIColor.white//(r: 85, g: 185, b: 85)
        matchesCollectionView.showsVerticalScrollIndicator = false
        matchesCollectionView.allowsSelection = true
        matchesCollectionView.alwaysBounceVertical = true
        matchesCollectionView.bounces = true
        
        self.view.addSubview(matchesCollectionView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchCell", for: indexPath) as! MatchCVC
        cell.backgroundColor = .gray
        
        //Check for a pre-existing Separator
        if(!cell.isSet) {
            //Set Separator Line
            let separator = cell.separator
            
            separator.backgroundColor = .gray
            
            separator.frame.size = CGSize(width: 2, height: cell.bounds.height)
            separator.frame.origin = CGPoint(x: cell.center.x - 1, y: 0)
            
            cell.addSubview(separator)
            
            //Set User Img 1
            let uImg1 = cell.userOneImg
            
            uImg1.image = #imageLiteral(resourceName: "DeeGee_Drake1")
            uImg1.contentMode = .scaleAspectFill
            uImg1.clipsToBounds = true
            
            uImg1.frame.origin = CGPoint(x: 0, y: 0)
            uImg1.frame.size = CGSize(width: (cell.frame.width / 2) - CGFloat(1), height: cell.frame.height)
            
            cell.addSubview(uImg1)
            
            //Set User Img 2
            let uImg2 = cell.userTwoImg
            
            uImg2.image = #imageLiteral(resourceName: "DeeGee_Drake2")
            uImg2.contentMode = .scaleAspectFill
            uImg2.clipsToBounds = true
            
            uImg2.frame.origin = CGPoint(x: cell.center.x + 1, y: 0)
            uImg2.frame.size = CGSize(width: (cell.frame.width / 2) - CGFloat(1), height: cell.frame.height)
            
            cell.addSubview(uImg2)
            
            cell.isSet = true
        } else {
            
        }
        
        /*
         cell.isUserInteractionEnabled = true;
         
         // User Photo
         cell.userImg.image = #imageLiteral(resourceName: "sgi-logo")
         cell.userImg.contentMode = .scaleAspectFit
         cell.userImg.clipsToBounds = true
         
         cell.userImg.frame.origin = CGPoint(x: 6, y: 6)
         cell.userImg.frame.size = CGSize(width: 30, height: 30)
         
         cell.userImg.layer.cornerRadius = cell.userImg.frame.width / 2
         cell.userImg.layer.borderColor = UIColor.black.cgColor
         cell.userImg.layer.borderWidth = 1
         
         cell.addSubview(cell.userImg)
         */
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.row) was selected!")
        
    }

    
    func setRightBarButton() {
        //create a new button
        let button: UIButton = UIButton(type: .custom)
        
        //set image for button
        button.setImage(#imageLiteral(resourceName: "afro_user_photo"), for: .normal)
        button.addTarget(self, action: #selector(profileButton), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        let barButton = UIBarButtonItem(customView: button)
        
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func profileButton() {
        print("sup")
        let profileVC = ProfileVC()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
}

//
//  MatchVotingVC.swift
//  DeeGee
//
//  Created by amota511 on 6/14/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit

class MatchVotingVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var matchesCV: UICollectionView!
    
    override func viewDidLoad() {
        self.title = "Matches"
        
        setRightBarButton()
        
        matchesCV.register(MatchCVC.self, forCellWithReuseIdentifier: "matchCell")
        matchesCV.backgroundColor = .green
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchCell", for: indexPath)
        cell.backgroundColor = .black
        return cell
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

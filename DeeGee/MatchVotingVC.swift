//
//  MatchVotingVC.swift
//  DeeGee
//
//  Created by amota511 on 6/14/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit

class MatchVotingVC: UIViewController {
    
    
    @IBAction func profileButton(_ sender: UIBarButtonItem) {
        print("sup")
        let profileVC = ProfileVC()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    override func viewDidLoad() {
        
    }

}

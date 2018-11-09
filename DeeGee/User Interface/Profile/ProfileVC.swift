//
//  ProfileVC.swift
//  DeeGee
//
//  Created by amota511 on 6/14/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileVC: UIViewController {
    
    var myUser: User? = nil
    var profilePhotoIsSet: Bool = false

    lazy var profilePhoto: UIImageView  = {
        let profilePhoto = UIImageView()
        profilePhoto.image = #imageLiteral(resourceName: "CarltonBanks")
        profilePhoto.contentMode = .scaleAspectFill
        profilePhoto.layer.borderWidth = 1
        profilePhoto.layer.borderColor = UIColor.black.cgColor
        profilePhoto.layer.cornerRadius = 3
        profilePhoto.clipsToBounds = true
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        
        profilePhoto.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewProfile))
        profilePhoto.addGestureRecognizer(gestureRecognizer)
        
        return profilePhoto
    }()
    
    lazy var viewProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("View Profile", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(viewProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var matchesButton: UIButton = {
        let button = UIButton()
        button.setTitle("My Matches", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor//UIColor(r: 230, g: 230, b: 230).cgColor
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(seeMatchesButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor//UIColor(r: 230, g: 230, b: 230).cgColor
        button.setTitleColor(UIColor.red, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(logoutButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        self.title = "Profile"
        
        if myUser == nil {
            print("going to enter populate user")
            populateMyUser()
        }
        
        if(myUser != nil && myUser!.image != nil) {
            self.profilePhoto.image = myUser!.image
        }
        
        view.addSubview(profilePhoto)
        view.addSubview(viewProfileButton)
        view.addSubview(matchesButton)
        view.addSubview(logoutButton)
        
        setProfilePhotoView()
        setViewProfileButton()
        setMyMatchesButton()
        setLogoutButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(myUser != nil && myUser!.image != nil && profilePhotoIsSet == false) {
            self.profilePhoto.image = myUser!.image
        }
    }
    
    func populateMyUser() {
        print("inside populate user")
        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot)  in
            
            if(!snapshot.hasChildren()) {
                print("error with retrieving user info from database")
                return
            }
            print(Auth.auth().currentUser!.uid)
            
            self.myUser = User(snapshot: snapshot)
            print("Got basic user data")
            self.profilePhoto.image = self.myUser?.image
        })
    }
    
    func setProfilePhotoView() {
        let navBarHeight = view.frame.height * 0.1
        profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: navBarHeight + 12).isActive = true
        profilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePhoto.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        profilePhoto.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
    }
    
    func setViewProfileButton() {
        viewProfileButton.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 3).isActive = true
        viewProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewProfileButton.widthAnchor.constraint(equalTo: profilePhoto.widthAnchor).isActive = true
        viewProfileButton.heightAnchor.constraint(equalTo: profilePhoto.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func setMyMatchesButton() {
        matchesButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -6).isActive = true
        matchesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        matchesButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        matchesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/14).isActive = true
    }
    
    func setLogoutButton() {
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.heightAnchor.constraint(equalTo: matchesButton.heightAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalTo: matchesButton.widthAnchor).isActive = true
    }
    
    @objc func seeMatchesButtonClicked() {
        print("matches button clicked")
        let myMatchesVC = MyMatchesVC()
        myMatchesVC.myUser = myUser
        self.navigationController?.pushViewController(myMatchesVC, animated: true)
    }
    
    @objc func logoutButtonClicked() {
        print("logout button clicked")
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("failed to sign out")
            let invalidLoginCredentialsAlert = UIAlertController(title: "Something Went Wrong", message: "Could Not Log Out At This Time", preferredStyle: .alert)
            invalidLoginCredentialsAlert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { (UIAlertAction) in
                invalidLoginCredentialsAlert.dismiss(animated:false, completion: nil)
            }))
            self.present(invalidLoginCredentialsAlert, animated: true, completion: nil)
            return
        }
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func viewProfile() {
        print("view button clicked")
        let viewProfileVC = ViewProfileVC()
        viewProfileVC.myUser = myUser
        self.navigationController?.pushViewController(viewProfileVC, animated: true)
    }
    
}


//
//  RegisterVC.swift
//  DeeGee
//
//  Created by amota511 on 6/14/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class RegisterVC: UIViewController, UITextFieldDelegate {

    lazy var profilePhoto: UIImageView = {
        let profilePhoto = UIImageView()
        profilePhoto.image = #imageLiteral(resourceName: "afro_user_photo")
        profilePhoto.contentMode = .scaleAspectFill
        profilePhoto.layer.borderWidth = 1
        profilePhoto.layer.borderColor = UIColor.black.cgColor
        profilePhoto.layer.cornerRadius = 3
        profilePhoto.clipsToBounds = true
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
    
        profilePhoto.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profilePhotoButtonClicked))
        profilePhoto.addGestureRecognizer(gestureRecognizer)
        return profilePhoto
    }()

     lazy var addProfilePhotoLabel: UILabel = {
        let label = UILabel()
        label.text = "Add A Photo"
        //label.font = label.font.withSize(20)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
     }()
    
    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.restorationIdentifier = "email"
        textField.textAlignment = .left
        textField.backgroundColor = UIColor.white
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.restorationIdentifier = "password"
        textField.textAlignment = .left
        textField.backgroundColor = UIColor.white
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.restorationIdentifier = "name"
        textField.textAlignment = .left
        textField.backgroundColor = UIColor.white
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    lazy var ageField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Age"
        textField.restorationIdentifier = "age"
        textField.textAlignment = .left
        textField.backgroundColor = UIColor.white
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    lazy var cityField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "City, Country"
        textField.restorationIdentifier = "city"
        textField.textAlignment = .left
        textField.backgroundColor = UIColor.white
        textField.returnKeyType = .go
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 50, g: 50, b: 50)
        button.setTitle("REGISTER", for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    var profilePhotoTaken: Bool = false
    var profilePhotoYAnchor: NSLayoutConstraint?
    var myUser: User? = nil
    var instanceIDToken: String = ""
    var uid: String? = ""
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Register"
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        
        view.addSubview(profilePhoto)
        view.addSubview(addProfilePhotoLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(nameField)
        view.addSubview(ageField)
        view.addSubview(cityField)
        view.addSubview(registerButton)
        
        
        setProfilePhoto()
        setAddProfilePhotoLabel()
        setEmailField()
        setPasswordField()
        setNameField()
        setAgeField()
        setCityField()
        setRegisterButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tapOutsideOfTextField = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        self.view.addGestureRecognizer(tapOutsideOfTextField)
    }
    
    func setProfilePhoto() {
        profilePhotoYAnchor = profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1 + 6)
        profilePhotoYAnchor?.isActive = true
        profilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePhoto.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        profilePhoto.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
    }
    
    func setAddProfilePhotoLabel() {
        addProfilePhotoLabel.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 0).isActive = true
        addProfilePhotoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addProfilePhotoLabel.widthAnchor.constraint(equalTo: profilePhoto.widthAnchor).isActive = true
        addProfilePhotoLabel.heightAnchor.constraint(equalTo: profilePhoto.heightAnchor, multiplier: 1/5).isActive = true
    }
    
    func setEmailField() {
        emailField.topAnchor.constraint(equalTo: addProfilePhotoLabel.bottomAnchor, constant: 36).isActive = true
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        emailField.heightAnchor.constraint(equalTo: profilePhoto.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func setPasswordField() {
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 1).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor).isActive = true
        passwordField.heightAnchor.constraint(equalTo: emailField.heightAnchor).isActive = true
    }
    
    func setNameField() {
        nameField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24).isActive = true
        nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameField.widthAnchor.constraint(equalTo: emailField.widthAnchor).isActive = true
        nameField.heightAnchor.constraint(equalTo: passwordField.heightAnchor).isActive = true
    }
    
    func setAgeField() {
        ageField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 1).isActive = true
        ageField.rightAnchor.constraint(equalTo: nameField.rightAnchor).isActive = true
        ageField.widthAnchor.constraint(equalTo: nameField.widthAnchor).isActive = true
        ageField.heightAnchor.constraint(equalTo: nameField.heightAnchor).isActive = true
    }
    
    func setCityField() {
        cityField.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 1).isActive = true
        cityField.rightAnchor.constraint(equalTo: nameField.rightAnchor).isActive = true
        cityField.widthAnchor.constraint(equalTo: nameField.widthAnchor).isActive = true
        cityField.heightAnchor.constraint(equalTo: nameField.heightAnchor).isActive = true
    }
    
    
    func setRegisterButton(){
        registerButton.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: cityField.bottomAnchor, constant: 24).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        registerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075).isActive = true
    }
    
    @objc func profilePhotoButtonClicked() {
        print("photo button clicked")
        showPhotoOptions()
    }
    
    @objc func handleRegister() {
        print("register button clicked")
        
        if profilePhotoTaken {
            
            print("No Profile Photo")
            let CouldNotRegisterAlert = UIAlertController(title: "Take A Profile Photo", message: "Click The Image To Take A Picture", preferredStyle: .alert)
            CouldNotRegisterAlert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (UIAlertAction) in
                CouldNotRegisterAlert.dismiss(animated:false, completion: nil)
            }))
            self.present(CouldNotRegisterAlert, animated: true, completion: nil)
            return
        }
        
        guard let email = emailField.text, let password = passwordField.text, let _ = nameField.text, let _ = ageField.text, let _ = cityField.text else{
            
            print("Form Is Not Valid")
            let CouldNotRegisterAlert = UIAlertController(title: "Missing Information", message: "Fill Out All Information", preferredStyle: .alert)
            CouldNotRegisterAlert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { (UIAlertAction) in
                CouldNotRegisterAlert.dismiss(animated:false, completion: nil)
            }))
            self.present(CouldNotRegisterAlert, animated: true, completion: nil)
            return
        }
        
        if password.count < 6 {
            
            let CouldNotRegisterAlert = UIAlertController(title: "Password Too Short", message: "Password Has To Be Atleast 6 Characters.", preferredStyle: .alert)
            CouldNotRegisterAlert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { (UIAlertAction) in
                CouldNotRegisterAlert.dismiss(animated:false, completion: nil)
            }))
            self.present(CouldNotRegisterAlert, animated: true, completion: nil)
        }
 
        
        Auth.auth().createUser(withEmail: email, password: password) { (usr, err) in
            
            if err != nil {
                let CouldNotRegisterAlert = UIAlertController(title: "Something Went Wrong", message: "Could Not Create User With This Information", preferredStyle: .alert)
                CouldNotRegisterAlert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { (UIAlertAction) in
                    CouldNotRegisterAlert.dismiss(animated:false, completion: nil)
                }))
                self.present(CouldNotRegisterAlert, animated: true, completion: nil)
                return
            }
            
            guard let user = usr?.user else{
                return
            }
            
            self.uid = user.uid
            
            self.storeUserData()
            
            
            self.performSegue(withIdentifier:"RegisterSuccessful", sender: self)
            self.navigationController?.popToRootViewController(animated: true)
        }
 
    }
    
    func storeUserData() {
        myUser = User(image: profilePhoto.image!, name: nameField.text!, age: ageField.text!, location: cityField.text!, uid: self.uid!)
        
        //let myUser = User(image: profilePhoto.image!, name: "Aaron", age: "21", location: "San Fran", uid: self.uid!)
        
        guard let usr = myUser else {return}
        
        let usersDBRef = Database.database().reference().child("Users").child(usr.uid)
        
        let values = [ "name" : usr.name,
                       "uid" : usr.uid,
                       "location" : usr.location,
                       "age" : usr.age] as [String : Any]
        usersDBRef.setValue(values)
        
        self.storeUserRemoteNotificationID()
    }
    
    func storeUserRemoteNotificationID() {
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                self.instanceIDToken = result.token
                self.storeProfilePhoto()
            }
        }
    }

    func storeProfilePhoto() {
        
        let dataObj: Data = UIImagePNGRepresentation(myUser!.image)!
        
        // Create a reference to the file you want to upload
        let userImgRef = Storage.storage().reference().child(myUser!.uid + ".png")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        userImgRef.putData(dataObj, metadata: metadata) { (metadata, err) in
            if err != nil {
                print("There was an err uploading the image", err.debugDescription)
                return
            }
            
            userImgRef.downloadURL(completion: { (url, err) in
                if err != nil {
                    print("There was an err getting the url", err.debugDescription)
                    return
                }
                print("URL", url!.absoluteString)
                
                let rootDBRef = Database.database().reference().child("UIDs").child(self.myUser!.uid)
                
                rootDBRef.child("imageURL").setValue(url!.absoluteString)
                rootDBRef.child("pushNotif").setValue(self.instanceIDToken)
            })
        }
    }
    
    func dissmissKeyboard(){
        
        if emailField.isEditing || passwordField.isEditing || nameField.isEditing || ageField.isEditing || cityField.isEditing {
            
            profilePhotoYAnchor?.isActive = false
            profilePhotoYAnchor = profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1 + 6)
            profilePhotoYAnchor?.isActive = true
            
            emailField.resignFirstResponder()
            passwordField.resignFirstResponder()
            nameField.resignFirstResponder()
            ageField.resignFirstResponder()
            cityField.resignFirstResponder()
            
            UIView.animate(withDuration: 1.25, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.2, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
                
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ state: UITextField) -> Bool {
        
        if state.restorationIdentifier == "email" {
            
            profilePhotoYAnchor?.isActive = false
            profilePhotoYAnchor = profilePhoto.topAnchor.constraint(equalTo: view.topAnchor)
            profilePhotoYAnchor?.isActive = true
        } else if state.restorationIdentifier == "password" {
            
            profilePhotoYAnchor?.isActive = false
            profilePhotoYAnchor = profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: -view.frame.height * 0.05)
            profilePhotoYAnchor?.isActive = true
        } else if state.restorationIdentifier == "name" {
            
            profilePhotoYAnchor?.isActive = false
            profilePhotoYAnchor = profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: (-view.frame.height * 0.05) * 2)
            profilePhotoYAnchor?.isActive = true
        } else if state.restorationIdentifier == "age" {
            
            profilePhotoYAnchor?.isActive = false
            profilePhotoYAnchor = profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: (-view.frame.height * 0.05) * 2)
            profilePhotoYAnchor?.isActive = true
        } else if state.restorationIdentifier == "city" {
            
            profilePhotoYAnchor?.isActive = false
            profilePhotoYAnchor = profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: (-view.frame.height * 0.05) * 2)
            profilePhotoYAnchor?.isActive = true
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.2, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        })
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.restorationIdentifier == "email" {
            passwordField.becomeFirstResponder()
        } else if textField.restorationIdentifier == "password" {
            nameField.becomeFirstResponder()
        } else if textField.restorationIdentifier == "name" {
            ageField.becomeFirstResponder()
        } else if textField.restorationIdentifier == "age" {
            cityField.becomeFirstResponder()
        } else if textField.restorationIdentifier == "city" {
            //call register fucntion
            handleRegister()
        }
        return true
    }
    
}

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func showPhotoOptions() {
        
        let photoSelectionAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        photoSelectionAlertController.addAction(UIAlertAction(title: "Use Camera", style: .default, handler: { (UIAlertAction) in
            self.performSegue(withIdentifier:"camera", sender: self)
        }))
        
        photoSelectionAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            photoSelectionAlertController.dismiss(animated: true)
        }))
        
        self.present(photoSelectionAlertController, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "camera" {
            let cameraVC = segue.destination as! CameraViewController
            cameraVC.destinationImageView = self.profilePhoto
        } else if segue.identifier == "RegisterSuccessful" {
            let matchVotingVC = (segue.destination as! UINavigationController).topViewController as! MatchVotingVC
            //MatchVotingVC
        }
    }

}

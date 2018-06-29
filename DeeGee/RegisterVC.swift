//
//  RegisterVC.swift
//  DeeGee
//
//  Created by amota511 on 6/14/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit
import AVFoundation

class RegisterVC: UIViewController {

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

     lazy var editProfilePhotoLabel: UILabel = {
        let label = UILabel()
        label.text = "Add A Photo"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
     }()
    
    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.textAlignment = .left
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.textAlignment = .left
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.textAlignment = .left
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var ageField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Age"
        textField.textAlignment = .left
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var cityField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "City, Country"
        textField.textAlignment = .left
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Register"
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        
        view.addSubview(profilePhoto)
        view.addSubview(editProfilePhotoLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(nameField)
        view.addSubview(ageField)
        view.addSubview(cityField)
        view.addSubview(registerButton)
        
        
        setProfilePhoto()
        setEditProfilePhotoLabel()
        setEmailField()
        setPasswordField()
        setNameField()
        setAgeField()
        setCityField()
        setRegisterButton()
        
    }
    
    func setProfilePhoto() {
        profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1 + 6).isActive = true
        profilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePhoto.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        profilePhoto.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
    }
    
    func setEditProfilePhotoLabel() {
        editProfilePhotoLabel.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 0).isActive = true
        editProfilePhotoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editProfilePhotoLabel.widthAnchor.constraint(equalTo: profilePhoto.widthAnchor).isActive = true
        editProfilePhotoLabel.heightAnchor.constraint(equalTo: profilePhoto.heightAnchor, multiplier: 1/5).isActive = true
    }
    
    func setEmailField() {
        emailField.topAnchor.constraint(equalTo: editProfilePhotoLabel.bottomAnchor, constant: 36).isActive = true
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        emailField.heightAnchor.constraint(equalTo: profilePhoto.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func setPasswordField() {
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 1).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        passwordField.heightAnchor.constraint(equalTo: profilePhoto.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func setNameField() {
        nameField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24).isActive = true
        nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        nameField.heightAnchor.constraint(equalTo: profilePhoto.heightAnchor, multiplier: 1/3).isActive = true
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
        //need x, y, width, height constraints
        registerButton.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        registerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075).isActive = true
        
    }


    @objc func profilePhotoButtonClicked() {
        print("photo button clicked")
        showPhotoOptions()
    }
    
    @objc func handleRegister() {
        print("register button clicked")
        self.performSegue(withIdentifier:"Login", sender: self)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
}

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func showPhotoOptions() {
        
        let photoSelectionAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        photoSelectionAlertController.addAction(UIAlertAction(title: "Import From Camera Roll", style: .default, handler: { (UIAlertAction) in
            
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                //self.selectedCell = collectionView.cellForItem(at: indexPath) as! AddSneakerCVCell?
                let picker = UIImagePickerController()
                picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
                picker.sourceType = .photoLibrary
                picker.allowsEditing = false
                self.present(picker, animated: true, completion: nil)
                
            }else {
                print("The camera roll is not available")
            }
        }))
        
        
        photoSelectionAlertController.addAction(UIAlertAction(title: "Use Camera", style: .default, handler: { (UIAlertAction) in
            
            
            
            //self.navigationController?.pushViewController(cameraVC, animated: true)
            
            
            self.performSegue(withIdentifier:"camera", sender: self)
            
            
            /*
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .camera
                picker.cameraDevice = .front
                picker.allowsEditing = false
                picker.cameraViewTransform = CGAffineTransform(scaleX: -1, y: 1) //(picker.cameraViewTransform, -1, 1)
                
                let overlay = UIImageView(image: #imageLiteral(resourceName: "face_outline_dark"))
                overlay.frame = CGRect(x: picker.view.frame.width * 0.1, y: 0, width: picker.view.frame.width * 0.8, height: picker.view.frame.height * 0.75)
                overlay.contentMode = .scaleAspectFit
                
                //picker.cameraOverlayView = overlay
                picker.showsCameraControls = false
                
                self.present(picker, animated: true, completion: nil)
             
            
            }else {
                print("The camera is not available")
            }
            */
        }))
        
        
        photoSelectionAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            photoSelectionAlertController.dismiss(animated: true)
        }))
        
        self.present(photoSelectionAlertController, animated: true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        profilePhoto.image = nil
        //let flippedImage = UIImage(CGImage: image.cgImage, scale: image.scale, orientation:)
        let flippedimage = image.imageFlippedForRightToLeftLayoutDirection()
        profilePhoto.image = image
        print("Image picked")
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        profilePhoto.image = nil
        profilePhoto.image = (info[UIImagePickerControllerOriginalImage] as! UIImage?)//?.imageFlippedForRightToLeftLayoutDirection()
        picker.dismiss(animated: true) {
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cameraVC = segue.destination as! CameraViewController
        cameraVC.destinationImageView = self.profilePhoto
    }
}

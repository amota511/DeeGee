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

     lazy var editProfilePhotoLabel: UILabel = {
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
    
    var faceStructurePoints = [CGPoint]()
    
    var uid: String! = nil
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    var profilePhotoYAnchor: NSLayoutConstraint?
    
    /*
     *
     *
     *
     *
     var logoViewYAnchor: NSLayoutConstraint?
     *
     *
     *
     *
     */
    
    
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        let tapOutsideOfTextField = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        self.view.addGestureRecognizer(tapOutsideOfTextField)
    }
    
    func setProfilePhoto() {
        profilePhotoYAnchor = profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1 + 6)
        profilePhotoYAnchor?.isActive = true
        //profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1 + 6).isActive = true
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
        /*
        guard let email = emailField.text, let password = passwordField.text, let _ = nameField.text, let _ = cityField.text, let _ = ageField.text else{
            
            print("Form Is Not Valid")
            let CouldNotRegisterAlert = UIAlertController(title: "Missing Information", message: "Fill Out All Information", preferredStyle: .alert)
            CouldNotRegisterAlert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { (UIAlertAction) in
                CouldNotRegisterAlert.dismiss(animated:false, completion: nil)
            }))
            self.present(CouldNotRegisterAlert, animated: true, completion: nil)
            return
        }
        */
        
        Auth.auth().createUser(withEmail: "aaron2@gmail.com", password: "qqqqqq") { (usr, err) in
            
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
            
            
            
//            let usersReference = rootRef.child("Users").child(uid)
//            let values = [ "name" : name,
//                           "uid" : uid,
//                           "location" : city,
//                           "age" : age,
//                           "matches" : []] as [String : Any]
//            usersReference.setValue(values)
            
            
            self.performSegue(withIdentifier:"RegisterSuccessful", sender: self)
            self.navigationController?.popToRootViewController(animated: true)
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
            profilePhotoYAnchor = profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: (-view.frame.height * 0.05) * 3)
            profilePhotoYAnchor?.isActive = true
        } else if state.restorationIdentifier == "age" {
            
            profilePhotoYAnchor?.isActive = false
            profilePhotoYAnchor = profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: (-view.frame.height * 0.05) * 4)
            profilePhotoYAnchor?.isActive = true
        } else if state.restorationIdentifier == "city" {
            
            profilePhotoYAnchor?.isActive = false
            profilePhotoYAnchor = profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: (-view.frame.height * 0.05) * 5)
            profilePhotoYAnchor?.isActive = true
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.2, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            
        }
        
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
        if segue.identifier == "camera" {
            let cameraVC = segue.destination as! CameraViewController
            cameraVC.destinationImageView = self.profilePhoto
        } else if segue.identifier == "RegisterSuccessful" {
            //let matchesVC = segue.destination as! MatchVotingVC
            
            let facestructure = FaceStructure(faceLandmarks: faceStructurePoints)
            facestructure.bottomLipHeight = 3
            //let myUser = User(image: profilePhoto.image!, name: nameField.text!, age: ageField.text!, location: cityField.text!, uid: uid, faceStructure: facestructure)
            var instanceIDToken: String = ""
            
            InstanceID.instanceID().instanceID { (result, error) in
                if let error = error {
                    print("Error fetching remote instange ID: \(error)")
                } else if let result = result {
                    print("Remote instance ID token: \(result.token)")
                    instanceIDToken = result.token
                }
            }
            
            let myUser = User(image: profilePhoto.image!, name: "Aaron", age: "21", location: "San Fran", uid: "VdRz6VoLnQgwdxzAYMQf9NUiJBK2", faceStructure: facestructure)
            
            let rootRef = Database.database().reference()
            
            let usersReference = rootRef.child("Users").child(myUser.uid)
            
            //rootRef.child("UIDs").updateChildValues([myUser.uid: 0])
            
            
            let values = [ "name" : myUser.name,
                           "uid" : myUser.uid,
                           "location" : myUser.location,
                           "age" : myUser.age,
                           "faceStructure" : myUser.faceStructure.toAnyObject(),
                           "matches" : myUser.matches] as [String : Any]
            usersReference.setValue(values)
            
            // File located on disk
            //let localFile = URL(string: "path/to/image")!
            var token = ""
            InstanceID.instanceID().instanceID { (res, err) in
                if err != nil {
                    //something bad happend
                } else {
                    token = res!.token
                }
            }
            
            let dataObj: Data = UIImagePNGRepresentation(self.profilePhoto.image!)!
            
            // Create a reference to the file you want to upload
            let storageRef = Storage.storage().reference()
            let userImgRef = storageRef.child("\(myUser.uid!).png")
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            
            let uploadTask = userImgRef.putData(dataObj, metadata: metadata) { (metadata, err) in
                if err != nil {
                    print("There was an err", err.debugDescription)
                    return
                }
                print("File upload worked!")
                userImgRef.downloadURL(completion: { (url, err) in
                    if err != nil {
                        print("There was an err in the url", err.debugDescription)
                        return
                    }
                    print("URL URL URL URL URL URL URL URL URL URL URL URL URL URL URL URL URL URL URL URL URL URL URL URL", url!.absoluteURL, url!.absoluteString)
                    usersReference.child("imageUrl").setValue(url!.absoluteString)
                    rootRef.child("UIDs").child(myUser.uid!).child("imageURL").setValue(url!.absoluteString)
                    rootRef.child("UIDs").child(myUser.uid!).child("pushNotif").setValue(token)
                })
            }
            
            /*
            // Upload the file to the path "Users/\(myUser.uid).jpg"
            let uploadTask = userImgRef.putFile(from: localFile, metadata: nil) { metadata, error in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
 
            
            // You can also access to download URL after upload.
            let uploadTask = userImgRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    
                    return
                }
            }
            */
 
           
             // Add a progress observer to an upload task
             let observer = uploadTask.observe(.progress) { snapshot in
             // A progress event occured
                print(snapshot.progress?.fileCompletedCount)
             }
             /*
             uploadTask.observe(.progress) { snapshot in
             // Upload reported progress
             let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
             / Double(snapshot.progress!.totalUnitCount)
             }
            
             uploadTask.observe(.success) { snapshot in
             // Upload completed successfully
             }
             */
                 
 
            
            
            //matchesVC.myUser = myUser
        }
    }
}

//
//  ViewController.swift
//  Feasta
//
//  Created by amota511 on 4/4/18.
//  Copyright © 2018 Aaron Motayne. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class LoginVC: UIViewController, UITextFieldDelegate {
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor(red: 204/255, green: 47/255, blue: 40/255, alpha: 1.0)
        sc.setTitleTextAttributes(["Color": "White"], for: .normal)
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    let inputsContainerView: UIView  = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 50, g: 50, b: 50)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleRegisterLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up By Clicking Here", for: .normal)
        button.setTitleColor(UIColor(red: 204/255, green: 47/255, blue: 40/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(12)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var emailTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.returnKeyType = .next
        tf.delegate = self
        return tf
    }()
    
    let emailSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 200, g: 200, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.returnKeyType = .go
        tf.delegate = self
        return tf
    }()
    
    let passwordSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 200, g: 200, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let refridgerdata: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "System-Bold", size: 45)
        label.text = "FEASTA"
        label.textColor =  UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    func textFieldShouldBeginEditing(_ state: UITextField) -> Bool {
//        inputsContainerViewYAnchor?.isActive = false
//        inputsContainerViewYAnchor = inputsContainerView.topAnchor.constraint(equalTo: refridgerdata.bottomAnchor, constant: 35)
//        inputsContainerViewYAnchor?.isActive = true
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.2, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            
        }
        
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleRegisterLogin()
        return true
    }
    
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor(red: 204/255, green: 47/255, blue: 40/255, alpha: 1.0)
        
        //view.addSubview(refridgerdata)
        //setRefridgerdata()
        
        
        //view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(passwordSeparatorView)
        view.addSubview(signUpButton)
        
        //setloginRegisterSegmentedControl()
        setInputContainerView()
        setLoginRegisterButton()
        setEmailTextField()
        setEmailSeparatorView()
        setPasswordTextField()
        setPaswordSeparatorView()
        setSignUpButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = ""
        super.viewDidAppear(true)
        
        if Auth.auth().currentUser?.uid != nil {
            self.performSegue(withIdentifier:"Login", sender: self)
        }else{
            print("User is not logged in")
            let tapOutsideOfTextField = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
            self.view.addGestureRecognizer(tapOutsideOfTextField)
        }
    }
    
    
    
    func setRefridgerdata(){
        
        refridgerdata.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        refridgerdata.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        refridgerdata.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        refridgerdata.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
    }
    
    func setloginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        loginRegisterSegmentedControlYAnchor = loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo:inputsContainerView.topAnchor, constant: -12)
        loginRegisterSegmentedControlYAnchor?.isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant:view.frame.height * 0.06833).isActive = true
    }
    
    
    @objc func handleLoginRegisterChange(){
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    //var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    var inputsContainerViewYAnchor: NSLayoutConstraint?
    var loginRegisterSegmentedControlYAnchor : NSLayoutConstraint?
    var loginRegisterButtonYAnchor: NSLayoutConstraint?
    
    func setInputContainerView(){
        //need x, y, width, height constraints
        inputsContainerView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        inputsContainerViewYAnchor = inputsContainerView.centerYAnchor.constraint(equalTo:view.centerYAnchor, constant: -36)
        inputsContainerViewYAnchor?.isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo:view.widthAnchor,constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.205)
        inputsContainerViewHeightAnchor?.isActive = true
    }
    
    func setLoginRegisterButton(){
        //need x, y, width, height constraints
        loginRegisterButton.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo:inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant:view.frame.height * 0.06833).isActive = true
        
    }
    
    @objc func handleRegisterLogin(){
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        }else{
            handleRegister()
        }
    }
    
    func handleLogin(){
        guard let email = emailTextField.text, let password = passwordTextField.text else{
            print("Form Is Not Valid")
            
            let invalidLoginCredentialsAlert = UIAlertController(title: "Enter an Email and Password", message: "Could Not Login With This Information", preferredStyle: .alert)
            invalidLoginCredentialsAlert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { (UIAlertAction) in
                invalidLoginCredentialsAlert.dismiss(animated:false, completion: nil)
            }))
            self.present(invalidLoginCredentialsAlert, animated: true, completion: nil)
            return
        }
        
        //self.performSegue(withIdentifier:"Login", sender: self)
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                let invalidLoginCredentialsAlert = UIAlertController(title: "Something Went Wrong", message: "Could Not Login With This Information", preferredStyle: .alert)
                invalidLoginCredentialsAlert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { (UIAlertAction) in
                    invalidLoginCredentialsAlert.dismiss(animated:false, completion: nil)
                }))
                self.present(invalidLoginCredentialsAlert, animated: true, completion: nil)
                return
            }
            print("Successfully logged in user")
            self.performSegue(withIdentifier: "Login", sender: self)
        })
    }
    
    func handleRegister(){
        guard let email = emailTextField.text, let password = passwordTextField.text else{
            print("Form Is Not Valid")
            return
        }
        
        self.performSegue(withIdentifier:"Login", sender: self)
        
//        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
//            (user: FIRUser?, error: Error?) in
//            if error != nil{
//                let CouldNotRegisterAlert = UIAlertController(title: "Something Went Wrong", message: "Could Not Create User With This Information", preferredStyle: .alert)
//                CouldNotRegisterAlert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { (UIAlertAction) in
//                    CouldNotRegisterAlert.dismiss(animated:false, completion: nil)
//                }))
//                self.present(CouldNotRegisterAlert, animated: true, completion: nil)
//                return
//            }
//
//            guard let uid = user?.uid else{
//                return
//            }
//
//            let ref = FIRDatabase.database().reference(fromURL: "https://refrigerdata-ab823.firebaseio.com/")
//            let usersReference = ref.child("Users").child(uid)
//            let values = [ "name" : name,
//                           "email" : email,
//                           "friges" : []] as [String : Any]
//
//            usersReference.updateChildValues( values as [NSObject : AnyObject], withCompletionBlock: { (err, ref) in
//                if err != nil {
//                    print(err as Any)
//                    return
//                }
//                print("Saved user successfully into firebase db")
//            })
//
//            FIRDatabase.database().reference().child("Emails").child(email.replacingOccurrences(of: ".com", with: "")).setValue(uid)
//
//            print("Successfully registered user")
//            self.performSegue(withIdentifier:"Login", sender: self)
//        })
    }
    
    
    func setEmailTextField(){
        emailTextField.leftAnchor.constraint(equalTo:inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo:inputsContainerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo:inputsContainerView.heightAnchor, multiplier: 1/2)
        emailTextFieldHeightAnchor?.isActive = true
        
    }
    
    func setEmailSeparatorView(){
        emailSeparatorView.leftAnchor.constraint(equalTo:inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo:emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant:1).isActive = true
        
    }
    
    func setPasswordTextField(){
        passwordTextField.leftAnchor.constraint(equalTo:inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo:emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo:inputsContainerView.heightAnchor, multiplier: 1/2)
        passwordTextFieldHeightAnchor?.isActive = true
        
    }
    
    func setPaswordSeparatorView(){
        passwordSeparatorView.leftAnchor.constraint(equalTo:inputsContainerView.leftAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo:passwordTextField.bottomAnchor).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant:1).isActive = true
        
    }
    
    func setSignUpButton() {
        signUpButton.centerXAnchor.constraint(equalTo: loginRegisterButton.centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor, constant: 12).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: loginRegisterButton.widthAnchor, multiplier: 1/2).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func dissmissKeyboard(){
        
        if  emailTextField.isEditing || passwordTextField.isEditing {
            inputsContainerViewYAnchor?.isActive = false
            inputsContainerViewYAnchor = inputsContainerView.centerYAnchor.constraint(equalTo:view.centerYAnchor)
            inputsContainerViewYAnchor?.isActive = true
        
            emailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            
            UIView.animate(withDuration: 1.25, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.2, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
                
            }
        }
        
        //        if nameTextField.isEditing {
        //            nameTextField.resignFirstResponder()
        //            return
        //        }else if emailTextField.isEditing {
        //            emailTextField.resignFirstResponder()
        //            return
        //        }else if passwordTextField.isEditing {
        //            passwordTextField.resignFirstResponder()
        //        }
        
    }
    
    @objc func signUpButtonClicked() {
        print("howdy")
        //let registerVC = RegisterVC()
        //self.navigationController?.pushViewController(registerVC, animated: true)
        self.title = "Login"
        self.performSegue(withIdentifier:"loginToRegister", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Login") {
            let user1 = User(image: UIImage(), name: "Aaron", age: "21", location: "San Francisco", uid: (Auth.auth().currentUser?.uid)!, faceStructure: FaceStructure())
            let dest = segue.destination as! MatchVotingVC
            dest.myUser = user1
        }
    }
    
}

extension UIColor{
    
    convenience init (r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}


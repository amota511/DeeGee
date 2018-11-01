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


class LoginVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

    //@IBOutlet weak var oldlogoView: UIImageView!
    //@IBOutlet weak var oldLogoView: UIImageView!
    
    lazy var logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage.init(named: "DeeGee_Logo")
        logoView.contentMode = .scaleAspectFit
        logoView.layer.borderWidth = 1
        logoView.layer.borderColor = UIColor.black.cgColor
        logoView.layer.cornerRadius = 3
        logoView.clipsToBounds = true
        logoView.translatesAutoresizingMaskIntoConstraints = false
        /*
        profilePhoto.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profilePhotoButtonClicked))
        profilePhoto.addGestureRecognizer(gestureRecognizer)
        */
        return logoView
    }()
    

    
    let inputsContainerView: UIView  = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var emailTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.returnKeyType = .next
        tf.delegate = self
        tf.restorationIdentifier = "email"
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
        tf.restorationIdentifier = "password"
        return tf
    }()
    
    let passwordSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 200, g: 200, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 50, g: 50, b: 50)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Click Here To Register", for: .normal)
        button.setTitleColor(UIColor(red: 204/255, green: 47/255, blue: 40/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(12)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.bounces = true
        sv.delegate = self
        sv.contentSize = self.view.bounds.size
        sv.isScrollEnabled = false
        return sv
    }()
    
    var name = String()
    
    var logoViewYAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoView)
        view.addSubview(inputsContainerView)
        view.addSubview(loginButton)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(passwordSeparatorView)
        view.addSubview(registerButton)
        
        setlogo()
        setInputContainerView()
        setLoginButton()
        setEmailTextField()
        setEmailSeparatorView()
        setPasswordTextField()
        setPaswordSeparatorView()
        setRegisterButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = ""
        super.viewDidAppear(true)
        
        if Auth.auth().currentUser?.uid != nil {
            self.performSegue(withIdentifier:"login", sender: self)
        }else{
            print("User is not logged in")
            let tapOutsideOfTextField = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
            self.view.addGestureRecognizer(tapOutsideOfTextField)
        }
    }
    
    func setlogo() {
        logoViewYAnchor = logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1 + 6)
        logoViewYAnchor?.isActive = true
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        logoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
    }

    func setInputContainerView(){
        //need x, y, width, height constraints
        inputsContainerView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo:logoView.bottomAnchor, constant: 50).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo:view.widthAnchor,constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.205).isActive = true
    }
    
    func setLoginButton(){
        //need x, y, width, height constraints
        loginButton.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo:inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant:view.frame.height * 0.06833).isActive = true
    }
    
    @objc func handleLogin(){
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form Is Not Valid")
            
            let invalidLoginCredentialsAlert = UIAlertController(title: "Enter an Email and Password", message: "Could Not Login With This Information", preferredStyle: .alert)
            invalidLoginCredentialsAlert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { (UIAlertAction) in
                invalidLoginCredentialsAlert.dismiss(animated:false, completion: nil)
            }))
            self.present(invalidLoginCredentialsAlert, animated: true, completion: nil)
            return
        }
        
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
            self.performSegue(withIdentifier: "login", sender: self)
        })
    }
    
    func handleRegister(){
        
        self.performSegue(withIdentifier:"loginToRegister", sender: self)
    }
    
    
    func setEmailTextField(){
        emailTextField.leftAnchor.constraint(equalTo:inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo:inputsContainerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        
        emailTextField.heightAnchor.constraint(equalTo:inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
        
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
        passwordTextField.heightAnchor.constraint(equalTo:inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    func setPaswordSeparatorView(){
        passwordSeparatorView.leftAnchor.constraint(equalTo:inputsContainerView.leftAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo:passwordTextField.bottomAnchor).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant:1).isActive = true
        
    }
    
    func setRegisterButton() {
        registerButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24).isActive = true
        registerButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor, multiplier: 1/2).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func dissmissKeyboard(){
        
        if  emailTextField.isEditing || passwordTextField.isEditing {
            
            logoViewYAnchor?.isActive = false
            logoViewYAnchor = logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1 + 6)
            logoViewYAnchor?.isActive = true
            
            emailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            
            UIView.animate(withDuration: 1.25, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.2, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
                
            }
        }
    }
    
    @objc func signUpButtonClicked() {
        print("howdy")
        //let registerVC = RegisterVC()
        //self.navigationController?.pushViewController(registerVC, animated: true)
        self.title = "Login"
        self.performSegue(withIdentifier:"loginToRegister", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "login") {
            //let user1 = User(image: UIImage(), name: "Aaron", age: "21", location: "San Francisco", uid: (Auth.auth().currentUser?.uid)!, faceStructure: FaceStructure())
            //let dest = segue.destination as! MatchVotingVC
            //dest.myUser = user1
        }
    }
    
    func textFieldShouldBeginEditing(_ state: UITextField) -> Bool {

        if state.restorationIdentifier == "email" {
           
            logoViewYAnchor?.isActive = false
            logoViewYAnchor = logoView.topAnchor.constraint(equalTo: view.topAnchor)
            logoViewYAnchor?.isActive = true
        } else if state.restorationIdentifier == "password" {

            logoViewYAnchor?.isActive = false
            logoViewYAnchor = logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: -view.frame.height * 0.05)
            logoViewYAnchor?.isActive = true
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.2, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            
        }

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.restorationIdentifier == "email" {
            passwordTextField.becomeFirstResponder()
        } else if textField.restorationIdentifier == "password" {
            passwordTextField.resignFirstResponder()
            handleLogin()
        }
        return true
    }
}

extension UIColor{
    
    convenience init (r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}


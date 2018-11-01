//
//  MatchVotingVC.swift
//  DeeGee
//
//  Created by amota511 on 6/14/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class MatchVotingVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var matchesCollectionView: UICollectionView!
    
    lazy var noMatchesLabel: UILabel! = {
        let lb = UILabel()
        lb.text = " Loading... "
        lb.textColor = .lightGray
        lb.textAlignment = .left
        lb.layer.borderWidth = 2
        lb.layer.borderColor = UIColor.lightGray.cgColor
        lb.layer.cornerRadius = 7
        lb.adjustsFontSizeToFitWidth = true
        lb.clipsToBounds = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    var myUser: User? = nil
    
    override func viewDidLoad() {
        self.title = "Matches"
        self.view.backgroundColor = .white
        
        setRightBarButton()
        setupMatchCV()
        setupNoMatchesLabel()
        
        print("checking if myUser == nil")
        if myUser == nil {
            print("going to enter populate user")
            populateMyUser()
        }
    }
    
    func populateMyUser() {
        print("inside populate user")
        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot)  in
            
            if(!snapshot.hasChildren()) {
                print("error with retrieving image url from database")
            }
            
            self.myUser = User(snapshot: snapshot)
            print("Got basic user data")
        Database.database().reference().child("UIDs").child(Auth.auth().currentUser!.uid).child("imageURL").observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) -> Void in
                if(!snapshot.hasChildren()) {
                    print("error with retrieving image url from database")
                    return
                }
                print("Got user img url")
                self.myUser?.imageURL = snapshot.value as? String
                Storage.storage().reference(forURL: self.myUser!.imageURL).getData(maxSize: 10000000, completion: { (data, err) in
                    if(err != nil) {
                        print("error with retrieving image from storage", err.debugDescription)
                        return
                    }
                    print("Got user img")
                    guard let data = data else {return}
                    self.myUser?.image = UIImage(data: data)
                    
                    print("data")
                })
            })
        })
    }
    
    func setupNoMatchesLabel() {

        view.insertSubview(noMatchesLabel, at: view.subviews.count)

        noMatchesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noMatchesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noMatchesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/6).isActive = true
        noMatchesLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        UIView.animate(withDuration: 6.0, delay: 0.0, options: [.repeat,.autoreverse], animations: {
            self.noMatchesLabel.text = " Loading "
            self.noMatchesLabel.text = " Loading. "
        }) { (complete) in
//            UIView.animate(withDuration: 1.0, animations: {
//                self.noMatchesLabel.text = " Loading. "
//            }, completion: { (compl) in
//                UIView.animate(withDuration: 1.0, animations: {
//                    self.noMatchesLabel.text = " Loading.. "
//                }, completion: { (com) in
//                    UIView.animate(withDuration: 1.0, animations: {
//                        self.noMatchesLabel.text = " Loading... "
//                    })
//                })
//            })
        }
    }
    
    func setupMatchCV() {
       
        let matchLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        matchLayout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        matchLayout.minimumInteritemSpacing = 0
        matchLayout.minimumLineSpacing = 8
        matchLayout.itemSize = CGSize(width: view.frame.width * 0.95, height: view.frame.height * 0.35)
        matchLayout.scrollDirection = .vertical
        
        
        matchesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: matchLayout)
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
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchCell", for: indexPath) as! MatchCVC
        cell.backgroundColor = .gray
        cell.contentView.clipsToBounds = true
        cell.clipsToBounds = true

        //Set Separator Line
        let separator = cell.separator
        separator.backgroundColor = .gray
        separator.frame.size = CGSize(width: 2, height: cell.bounds.height)
        separator.frame.origin = CGPoint(x: cell.center.x - 1, y: 0)
        
        cell.addSubview(separator)
        
        cell.layer.shadowOffset = CGSize(width: 30, height: 30)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
        let storageRef = Storage.storage().reference()
        //let userImgRef = storageRef.child(myUser!.uid + ".png")
        let userImgRef = storageRef.child("VdRz6VoLnQgwdxzAYMQf9NUiJBK2.png")
        let uImg1 = cell.userImgOne
        /*
        userImgRef.getData(maxSize: 100 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                uImg1.image = UIImage(data: data!)
            }
        }
        */
        uImg1.image = #imageLiteral(resourceName: "DeeGee_Drake1")
        uImg1.contentMode = .scaleAspectFill
        uImg1.clipsToBounds = true
        uImg1.frame.origin = CGPoint(x: 0, y: 0)
        uImg1.frame.size = CGSize(width: (cell.frame.width / 2) - CGFloat(1), height: cell.frame.height)
        
        cell.addSubview(uImg1)
        
        //Set User Img 2
        let uImg2 = cell.userImgTwo
        /*
        Storage.storage().reference().child("VdRz6VoLnQgwdxzAYMQf9NUiJBK2.png").getData(maxSize: 100 * 1024 * 1024)
            { data, error in
                if let error = error {
                    print(error)
                } else {
                    uImg2.image = UIImage(data: data!)
                }
            }
        */
        uImg2.image = #imageLiteral(resourceName: "DeeGee_Drake2")
        uImg2.contentMode = .scaleAspectFill
        uImg2.clipsToBounds = true
        uImg2.frame.origin = CGPoint(x: cell.frame.width / 2 + CGFloat(1), y: 0)
        uImg2.frame.size = CGSize(width: (cell.frame.width / 2) - CGFloat(1), height: cell.frame.height)
        
        cell.addSubview(uImg2)
        
        //Set Shadow
        let bottomShadow = cell.frostedBottom
        bottomShadow.image = #imageLiteral(resourceName: "DeeGee_bottomShadow")
        bottomShadow.contentMode = .scaleAspectFill
        bottomShadow.clipsToBounds = true
        bottomShadow.frame.origin = CGPoint(x: 0, y: cell.bounds.height - cell.bounds.height * 0.25)
        bottomShadow.frame.size = CGSize(width: cell.bounds.width, height: cell.bounds.height * 0.25)
        
        cell.addSubview(bottomShadow)
        
        
        //Set Username 1
        let uName1 = cell.userNameOne
        uName1.text = "Drake"
        uName1.textAlignment = .left
        uName1.textColor = .white
        uName1.frame.size = CGSize(width: uImg1.bounds.width - 2, height: bottomShadow.bounds.height * 0.6)
        uName1.frame.origin = CGPoint(x: 2, y: bottomShadow.frame.height - uName1.frame.height)
        uName1.textRect(forBounds: uName1.bounds, limitedToNumberOfLines: 1)
        uName1.font = uName1.font.withSize(25)
        
        bottomShadow.addSubview(uName1)
        
        //Set Username 2
        let uName2 = cell.userNameTwo
        uName2.text = "Not Drake"
        uName2.textAlignment = .right
        uName2.textColor = .white
        uName2.frame.size = CGSize(width: uImg2.bounds.width - 3, height: bottomShadow.bounds.height * 0.6)
        uName2.frame.origin = CGPoint(x: uImg1.bounds.width + 3, y: bottomShadow.frame.height - uName2.frame.height)
        uName2.textRect(forBounds: uName2.bounds, limitedToNumberOfLines: 1)
        uName2.font = uName2.font.withSize(25)
        
        bottomShadow.addSubview(uName2)
        
        
        let moreButton = cell.moreButton
        moreButton.image = #imageLiteral(resourceName: "three_dots")
        moreButton.contentMode = .scaleAspectFit
    
        moreButton.frame.size = CGSize(width: uImg1.frame.size.width * 0.2, height: 30)
        moreButton.frame.origin = CGPoint(x: cell.bounds.width - moreButton.frame.width - 8, y: bottomShadow.bounds.height * 0.1)
        
        moreButton.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreButtonClicked(_:)))
        moreButton.addGestureRecognizer(gestureRecognizer)
        
        moreButton.tag = indexPath.row
        print("gestureRecognizer.view!.tag = \(indexPath.row)")
        
        cell.addSubview(moreButton)
        
        cell.isUserInteractionEnabled = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.row) was selected!")
        
    }

    @objc func pressedYes(sender: UIButton) {
        print("we ight")
    }
    
    @IBAction func moreButtonClicked(_ sender: AnyObject?) {
        
        let row = (sender as! UITapGestureRecognizer).view!.tag
        guard let cell = matchesCollectionView.cellForItem(at: IndexPath(row: row, section: 0))! as? MatchCVC else { print("morebutton attempt failed"); return }
        print("more button clicked, tag# :", row)
        
        setupVotingView(cell: cell)
        
    }
    
    func setupVotingView(cell: UIView) {
        let view = cell.superview!
        
        var darkBlur:UIBlurEffect = UIBlurEffect()
        darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)//prominent,regular,extraLight, light, dark
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = cell.frame //your view that have any objects
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurView)
        
        
        let cancelButton = UIButton(frame: CGRect(origin: CGPoint(x: (blurView.frame.width - 25) - 12, y: 12), size: CGSize(width: 25, height: 25)))
        cancelButton.setImage(#imageLiteral(resourceName: "white_x"), for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.tintColor = .white
        cancelButton.addTarget(self, action: #selector(cancelBlurView(sender:)), for: .touchUpInside)
        blurView.contentView.addSubview(cancelButton)
        
        
        let question = UILabel()
        question.text = "Are They DoppleGangers?"
        question.textAlignment = .center
        question.textColor = .white
        question.font = question.font.withSize(30)
        question.numberOfLines = 2
        question.frame.size = CGSize(width: blurView.bounds.width * 0.6, height: blurView.bounds.height * 0.5)
        question.frame.origin = CGPoint(x: blurView.bounds.width / 2 - (question.frame.width / 2), y: blurView.bounds.height * 0.1)
        blurView.contentView.addSubview(question)
        
        
        let thumbsUpButton = UIImageView(image: #imageLiteral(resourceName: "thumbs_up_outline"), highlightedImage: #imageLiteral(resourceName: "thumbs_up_filled"))
        thumbsUpButton.frame = CGRect(x: question.frame.midX - 70, y: question.frame.origin.y + question.frame.height + 10, width: 50, height: 50)
        //thumbsUpButton.isHighlighted = true
        thumbsUpButton.isUserInteractionEnabled = true
        var gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(thumbsUpButtonClicked(_:)))
        thumbsUpButton.addGestureRecognizer(gestureRecognizer)
        blurView.contentView.addSubview(thumbsUpButton)
        
        
        let thumbsDownButton = UIImageView(image: #imageLiteral(resourceName: "thumbs_down_outline"), highlightedImage: #imageLiteral(resourceName: "thumbs_down_filled"))
        thumbsDownButton.frame = CGRect(x: question.frame.midX + 20, y: question.frame.origin.y + question.frame.height + 10, width: 50, height: 50)
        //thumbsUpButton.isHighlighted = true
        thumbsDownButton.isUserInteractionEnabled = true
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(thumbsDownButtonClicked(_:)))
        thumbsDownButton.addGestureRecognizer(gestureRecognizer)
        blurView.contentView.addSubview(thumbsDownButton)
    }
    
    @objc func cancelBlurView(sender: UIButton) {
        sender.superview?.superview?.removeFromSuperview()
        //sender.superview = nil
    }
    
    @objc func thumbsUpButtonClicked(_ sender: AnyObject?) {
        print("thumbs up highlighted")
        guard let imageview = (sender! as! UITapGestureRecognizer).view as? UIImageView else {print("error on thumbs up"); return }
        imageview.isHighlighted = !imageview.isHighlighted
    }
    
    @objc func thumbsDownButtonClicked(_ sender: AnyObject?) {
        print("thumbs down highlighted")
        guard let imageview = (sender! as! UITapGestureRecognizer).view as? UIImageView else {print("error on thumbs up"); return }
        imageview.isHighlighted = !imageview.isHighlighted
    }
    
    func setRightBarButton() {
        //create a new button
        let button: UIButton = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "afro_user_photo"), for: .normal)
        button.addTarget(self, action: #selector(profileButton), for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func profileButton() {
        print("sup")
        let profileVC = ProfileVC()
        profileVC.myUser = myUser
        self.navigationController?.pushViewController(profileVC, animated: true)
    }

}

//
//  MyMatchesVC.swift
//  DeeGee
//
//  Created by amota511 on 6/27/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyMatchesVC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    
    var myUser: User? = nil
    var matchesArray: [Match] = [Match]()
    var matchesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        populateMatchArray()
        
        self.title = "My Matches"
        self.view.backgroundColor = .white
        
        setupMatchCV()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        print(UIApplication.shared.applicationIconBadgeNumber, "badge numbers")
        
        if myUser == nil {
            let CouldNotRegisterAlert = UIAlertController(title: "Could Not Connect To The Internet", message: "Check Your Network And Try Again", preferredStyle: .alert)
            CouldNotRegisterAlert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (UIAlertAction) in
                CouldNotRegisterAlert.dismiss(animated: false, completion: nil)
            }))
            self.present(CouldNotRegisterAlert, animated: true, completion: nil)
        }
    }
    
    func populateMatchArray() {
        Database.database().reference().child("Matches").observe(.value, with: { (snapshot) in
            if (snapshot.hasChildren() == false) {
                print("There was an error downloading the matches")
                return
            }
            else {
                for match in snapshot.children {
                    self.matchesArray.append(Match(snapshot: match as! DataSnapshot))
                }
                self.matchesCollectionView.reloadData()
            }
        })
    }
    
    func setupMatchCV() {
        
        let matchLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        matchLayout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        matchLayout.minimumInteritemSpacing = 0
        matchLayout.minimumLineSpacing = 2
        matchLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height * 0.45)
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
        return matchesArray.count
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
            let uImg1 = cell.userImgOne
            uImg1.image = #imageLiteral(resourceName: "DeeGee_Drake1")
            uImg1.image = matchesArray[indexPath.row].userOneImg
            uImg1.contentMode = .scaleAspectFill
            uImg1.clipsToBounds = true
            uImg1.frame.origin = CGPoint(x: 0, y: 0)
            uImg1.frame.size = CGSize(width: (cell.frame.width / 2) - CGFloat(1), height: cell.frame.height)
            
            cell.addSubview(uImg1)
            
            //Set User Img 2
            let uImg2 = cell.userImgTwo
            uImg2.image = #imageLiteral(resourceName: "DeeGee_Drake2")
            uImg2.image = matchesArray[indexPath.row].userTwoImg
            uImg2.contentMode = .scaleAspectFill
            uImg2.clipsToBounds = true
            uImg2.frame.origin = CGPoint(x: cell.center.x + 1, y: 0)
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
            uName1.text = matchesArray[indexPath.row].userOneName
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
            uName2.text = matchesArray[indexPath.row].userTwoName
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
            
            //cell.addSubview(moreButton)
            
            //cell.isSet = true
        } else {
            
        }
        
        cell.isUserInteractionEnabled = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.row) was selected!")
        
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
        darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = cell.frame
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
    
}

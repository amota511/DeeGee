//
//  MatchVotingVC.swift
//  DeeGee
//
//  Created by amota511 on 6/14/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit

class MatchVotingVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //@IBOutlet weak var matchesCV: UICollectionView!
    
    var matchesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        self.title = "Matches"
        self.view.backgroundColor = .white
        setRightBarButton()
        
//        matchesCV.register(MatchCVC.self, forCellWithReuseIdentifier: "matchCell")
//        matchesCV.backgroundColor = .green
//        
//        
//        let flowlayout = UICollectionViewFlowLayout()
//        flowlayout.itemSize = CGSize(width: 50, height: 50)
//        flowlayout.scrollDirection = .vertical
//        flowlayout.sectionInset = .init(top: 3, left: 3, bottom: 3, right: 3)
//        
//        matchesCV.setCollectionViewLayout(flowlayout, animated: true)
//        
        setupMatchCV()
        
    }
    
    func setupMatchCV() {
       
        let matchLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        matchLayout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        matchLayout.minimumInteritemSpacing = 0
        matchLayout.minimumLineSpacing = 2
        matchLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height * 0.45)
        matchLayout.scrollDirection = .vertical
        
        
        matchesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height ), collectionViewLayout: matchLayout)
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
        return 15
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
            uImg1.contentMode = .scaleAspectFill
            uImg1.clipsToBounds = true
            
            uImg1.frame.origin = CGPoint(x: 0, y: 0)
            uImg1.frame.size = CGSize(width: (cell.frame.width / 2) - CGFloat(1), height: cell.frame.height)
            
            cell.addSubview(uImg1)
            
            //Set User Img 2
            let uImg2 = cell.userImgTwo
            
            uImg2.image = #imageLiteral(resourceName: "DeeGee_Drake2")
            uImg2.contentMode = .scaleAspectFill
            uImg2.clipsToBounds = true
            
            uImg2.frame.origin = CGPoint(x: cell.center.x + 1, y: 0)
            uImg2.frame.size = CGSize(width: (cell.frame.width / 2) - CGFloat(1), height: cell.frame.height)
            
            cell.addSubview(uImg2)
            
            //Set Shadow
            let bottomShadow = cell.frostedBottom
            
            bottomShadow.image = #imageLiteral(resourceName: "DeeGee_bottomShadow")
            //bottomShadow.alpha = 0.5
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
            
            uName1.frame.size = CGSize(width: uImg1.bounds.width - 2, height: bottomShadow.bounds.height * 0.3)
            uName1.frame.origin = CGPoint(x: 2, y: bottomShadow.frame.height - uName1.frame.height)
            
            uName1.textRect(forBounds: uName1.bounds, limitedToNumberOfLines: 1)
            
            bottomShadow.addSubview(uName1)
            
            //Set Username 2
            let uName2 = cell.userNameTwo
            
            uName2.text = "Not Drake"
            uName2.textAlignment = .right
            uName2.textColor = .white
            
            uName2.frame.size = CGSize(width: uImg2.bounds.width - 3, height: bottomShadow.bounds.height * 0.3)
            uName2.frame.origin = CGPoint(x: uImg1.bounds.width + 3, y: bottomShadow.frame.height - uName2.frame.height)
            
            uName2.textRect(forBounds: uName2.bounds, limitedToNumberOfLines: 1)
            
            bottomShadow.addSubview(uName2)
            
            //Set Question
            let question = cell.questionLabel
            
            question.text = "Are They DoppleGangers?"
            question.textAlignment = .center
            question.textColor = .white
            
            //question.backgroundColor = .cyan
            
            question.frame.size = CGSize(width: bottomShadow.bounds.width * 0.6, height: bottomShadow.bounds.height * 0.3)
            question.frame.origin = CGPoint(x: bottomShadow.bounds.width / 2 - (question.frame.width / 2), y: bottomShadow.bounds.height * 0.5)
            
            //bottomShadow.addSubview(question)
            
            //Set Yes Button
            let yesButton = cell.yesButton
            
            yesButton.setTitle("Yes!", for: .normal)
            yesButton.tintColor = .white
            yesButton.layer.borderWidth = 1
            yesButton.layer.borderColor = UIColor.white.cgColor
            yesButton.clipsToBounds = true
            yesButton.layer.cornerRadius = 5
            
            yesButton.frame.size = CGSize(width: uImg1.frame.size.width * 0.4, height: bottomShadow.bounds.height * 0.4)
            yesButton.frame.origin = CGPoint(x: 8, y: bottomShadow.bounds.height * 0.4)
            
            yesButton.addTarget(self, action: #selector(pressedYes(sender:)), for: .touchUpInside)
            yesButton.isUserInteractionEnabled = true
            
            //bottomShadow.addSubview(yesButton)
            
            //Set No Button
            let noButton = cell.noButton
            
            noButton.setTitle("No!", for: .normal)
            noButton.tintColor = .white
            noButton.layer.borderWidth = 1
            noButton.layer.borderColor = UIColor.white.cgColor
            noButton.clipsToBounds = true
            noButton.layer.cornerRadius = 5
            
            noButton.frame.size = CGSize(width: uImg1.frame.size.width * 0.4, height: bottomShadow.bounds.height * 0.4)
            noButton.frame.origin = CGPoint(x: cell.bounds.width - noButton.frame.width - 8, y: bottomShadow.bounds.height * 0.4)
            
            //bottomShadow.addSubview(noButton)
            
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
            
            //cell.isSet = true
        } else {
            
        }
        
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
        
        //set image for button
        button.setImage(#imageLiteral(resourceName: "afro_user_photo"), for: .normal)
        button.addTarget(self, action: #selector(profileButton), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.1, height: self.view.frame.width * 0.1)
        
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

//
//  Match.swift
//  DeeGee
//
//  Created by amota511 on 8/6/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class Match {
    
    var matchID: String!
    
    var userOneUID: String!
    var userTwoUID: String!
    
    var userOneImg: UIImage!
    var userTwoImg: UIImage!
    
    var userOneName: String!
    var userTwoName: String!
    
    var confidence: Float!
    
    /*
    var crowdSourcedPositiveVotes: [String]!
    var crowdSourcedNegativeVotes: [String]!
    */
    
    init(snapshot: DataSnapshot) {
        //let matchID = snapshot.key
        
        let dict = snapshot.value as? NSDictionary
        
        matchID = snapshot.key
        
        if let u1 = dict?["user1"] as? String {
            userOneUID = u1
            Database.database().reference().child("Users").child(u1).child("name").observeSingleEvent(of: .value, with: { (snap) in
                self.userOneName = snap.value as? String
            })
            Storage.storage().reference(withPath: u1 + ".png").getData(maxSize: 10000000, completion: { (data, err) in
                if(err != nil) {
                    print("error with retrieving image from storage", err.debugDescription)
                }
                guard let photoData = data else {
                    return
                }
                if data!.isEmpty {
                    return
                }
                
                self.userOneImg = UIImage(data: photoData)
            })
        }else {
            self.userOneUID = ""
            self.userOneName = ""
            self.userOneImg = UIImage()
        }
        
        if let u2 = dict?["user2"] as? String {
            userTwoUID = u2
            Database.database().reference().child("Users").child(u2).child("name").observeSingleEvent(of: .value, with: { (snap) in
                self.userTwoName = snap.value as? String
            })
            Storage.storage().reference(withPath: u2 + ".png").getData(maxSize: 10000000, completion: { (data, err) in
                if(err != nil) {
                    print("error with retrieving image from storage", err.debugDescription)
                }
                guard let photoData = data else {
                    return
                }
                if data!.isEmpty {
                    return
                }
                
                self.userTwoImg = UIImage(data: photoData)
            })
        }else {
            self.userTwoUID = ""
            self.userTwoName = ""
            self.userTwoImg = UIImage()
        }
        
        if let confidence = dict?["confidence"] as? Float{
            self.confidence = confidence
        }else{
            self.confidence = 0
        }
        
        /*
        if let posSimilarity = dict?["crowdSourcedPositiveVotes"] as? [String]{
            self.crowdSourcedPositiveVotes = posSimilarity
        }else{
            self.crowdSourcedPositiveVotes = []
        }
        
        if let negSimilarity = dict?["crowdSourcedNegativeVotes"] as? [String]{
            self.crowdSourcedNegativeVotes = negSimilarity
        }else{
            self.crowdSourcedNegativeVotes = []
        }
        */
    }
    
    /*
    func toAnyObject()-> [String : AnyObject] {
        return ["matchID": matchID as AnyObject, "userOne": userOneUID as AnyObject, "userTwo": userTwoUID as AnyObject, "confidence": confidence as AnyObject]
    }
    */
}

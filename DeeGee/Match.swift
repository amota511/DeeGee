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
    
    var userOne: User!
    var userTwo: User!
    
    var confidence: Float!
    
    /*
    var crowdSourcedPositiveVotes: [String]!
    var crowdSourcedNegativeVotes: [String]!
    */
    
    init(snapshot: DataSnapshot) {
        //let matchID = snapshot.key
        
        let dict = snapshot.value as? NSDictionary
        
        if let u1 = dict?["user1"] as? String {
            Database.database().reference().child("Users").child(u1).observeSingleEvent(of: .value) { (snap) in
                self.userOne = User(snapshot: snap)
            }
        }else {
            self.userOne = nil
        }
        
        if let u2 = dict?["user2"] as? String {
            Database.database().reference().child("Users").child(u2).observeSingleEvent(of: .value) { (snap) in
                self.userTwo = User(snapshot: snap)
            }
        }else {
            self.userTwo = nil
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
    
    func toAnyObject()-> [String : AnyObject] {
        return ["matchID": matchID as AnyObject, "userOne": userOne.uid as AnyObject, "userTwo": userTwo.uid as AnyObject, "confidence": confidence as AnyObject]
    }
}

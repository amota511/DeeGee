//
//  FullMatch.swift
//  
//
//  Created by amota511 on 7/8/18.
//

import UIKit
import Firebase
import FirebaseDatabase


class Match {
    
    var matchID: String!
    
    var userOne: User!
    var userTwo: User!
    
    var computerGeneratedSimilarity: Int!
    
    var crowdSourcedPositiveVotes: [String]!
    var crowdSourcedNegativeVotes: [String]!
    
    
    init(snapshot: DataSnapshot) {
        let matchID = snapshot.key
        
        let dict = snapshot.value as? NSDictionary
        
        let ref = Database.database().reference().child("Match").child(matchID)
        
        ref.child("user1").observeSingleEvent(of: .value) { (snapshot) in
            self.userOne = User(snapshot: snapshot)
        }

        ref.child("user2").observeSingleEvent(of: .value) { (snapshot) in
            self.userTwo = User(snapshot: snapshot)
        }
        
        if let comSimilarity = dict?["computerGeneratedSimilarity"] as? Int{
            self.computerGeneratedSimilarity = comSimilarity
        }else{
            self.computerGeneratedSimilarity = 0
        }
        
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
    }
    
    func toAnyObject()-> [String : AnyObject] {
        return ["matchID": matchID as AnyObject, "userOne": userOne.toAnyObject() as AnyObject, "userTwo": userTwo.toAnyObject() as AnyObject, "computerGeneratedSimilarity": computerGeneratedSimilarity as AnyObject, "crowdSourcedPositiveVotes": crowdSourcedPositiveVotes as AnyObject, "crowdSourcedNegativeVotes": crowdSourcedNegativeVotes as AnyObject]
    }
}

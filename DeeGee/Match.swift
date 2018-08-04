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
    var crowdSourcedSimilarity: Int!
    
    var listOfVoters: [String]!
    
    init(snapshot: DataSnapshot) {
        let matchID = snapshot.key
        
        let dict = snapshot.value as? NSDictionary
        
        let user1 = User(referenceKey: matchID, childNumber: "1")
        let user2 = User(referenceKey: matchID, childNumber: "2")
        
    }
    
}

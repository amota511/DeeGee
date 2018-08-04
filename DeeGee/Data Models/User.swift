//
//  User.swift
//  DeeGee
//
//  Created by amota511 on 7/28/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct User {
    
    var uid: String! = nil
    var image: UIImage! = nil
    var name: String! = nil
    var age: String! = nil
    var location: String! = nil
    var matches: [String]! = nil
    
    init(image: UIImage, name: String, age: String, location: String) {
        self.name = name
        self.image = image
        self.age = age
        self.location = location
    }
    init (referenceKey: String, childNumber: String) {
        let ref = Database.database().reference().child("Match").child(referenceKey).child(childNumber)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            /*if let name = value?["name"] as? String{
                self.name = name
            }else{
                self.name = ""
            }
            
            if let age = value?["age"] as? String{
                self.age = age
            }else{
                self.age = ""
            }
            
            if let location = value?["location"] as? String{
                self.location = location
            }else{
                self.location = ""
            }*/
        })
        
    }
    
    init(snapshot:DataSnapshot) {
        
        uid = snapshot.key
        
        let value = snapshot.value as? NSDictionary
        
        if let name = value?["name"] as? String{
            self.name = name
        }else{
            self.name = ""
        }
        
        if let age = value?["age"] as? String{
            self.age = age
        }else{
            self.age = ""
        }
        
        if let location = value?["location"] as? String{
            self.location = location
        }else{
            self.location = ""
        }
        
    }

    func toAnyObject()-> [String : AnyObject] {
        return ["name": name as AnyObject, "age": age as AnyObject, "location": location as AnyObject]
    }
}

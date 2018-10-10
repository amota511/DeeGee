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

class User {
    
    var uid: String! = nil
    var image: UIImage! = nil
    var name: String! = nil
    var age: String! = nil
    var location: String! = nil
    var faceStructure: FaceStructure! = nil
    var imageUrl: String! = nil
    var matches: [String]! = []
    
    init(image: UIImage, name: String, age: String, location: String, uid: String, faceStructure: FaceStructure) {
        self.uid = uid
        self.image = image
        self.name = name
        self.age = age
        self.location = location
        self.faceStructure = faceStructure
    }
    
    init (referenceKey: String, childNumber: String) {
        let ref = Database.database().reference().child("Match").child(referenceKey).child(childNumber)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let uid = value?["uid"] as? String{
                self.uid = uid
            }else{
                self.uid = ""
            }
            
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
        })
        
    }
    
    init(snapshot:DataSnapshot) {
        
        let value = snapshot.value as? NSDictionary
        
        if let uid = value?["uid"] as? String{
            self.uid = uid
        }else{
            self.uid = ""
        }
        
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
        return ["name": name as AnyObject, "age": age as AnyObject, "location": location as AnyObject, "uid": uid as AnyObject, "faceStructure" : faceStructure.toAnyObject() as AnyObject]
    }
}

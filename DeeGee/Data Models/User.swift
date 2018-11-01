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
    var imageURL: String! = nil
    var image: UIImage! = nil
    var name: String! = nil
    var age: String! = nil
    var location: String! = nil
    var matches: [String]! = []
    
    init(image: UIImage, name: String, age: String, location: String, uid: String) {
        self.uid = uid
        self.image = image
        self.name = name
        self.age = age
        self.location = location
    }

    init(snapshot:DataSnapshot) {
        
        let value = snapshot.value as? NSDictionary
        
        if let uid = value?["uid"] as? String{
            self.uid = uid
            Storage.storage().reference(withPath: uid + ".png").getData(maxSize: 10000000, completion: { (data, err) in
                if(err != nil) {
                    print("error with retrieving image from storage", err.debugDescription)
                }
                self.image = UIImage(data: data!)
            })
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
        
        if let matches = value?["matches"] as? [String]{
            self.matches = matches
        }else{
            self.matches = nil
        }
    }


    func toAnyObject()-> [String : AnyObject] {
        return ["name": name as AnyObject, "age": age as AnyObject, "location": location as AnyObject, "uid": uid as AnyObject]
    }
}

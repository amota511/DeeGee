//
//  FaceStructure.swift
//  DeeGee
//
//  Created by amota511 on 8/6/18.
//  Copyright © 2018 AaronMotayne. All rights reserved.
//

import UIKit

class FaceStructure {
    
    var eyeBrowWidth: Int! = 0
    var spaceBetweenEyes: Int! = 0
    var eyeWidth: Int! = 0
    var eyeHeight: Int! = 0
    
    var noseWidth: Int! = 0
    var noseHeight: Int! = 0
    var nostrilWidth: Int! = 0
    var nostrilHeight: Int! = 0
    
    var topLipHeight: Int! = 0
    var bottomLipHeight: Int! = 0
    var lipWidth: Int! = 0
    
    var chinHeight: Int! = 0
    var chinWidth: Int! = 0
    
    var faceWidth: Int! = 0
    var faceHeight: Int! = 0
    
    init() {
        /*Note to Aaron: the next you should do is finish this class.
            - Meaning create setter functions for each face landmark. Create
            - Create init for a uiImage to be passed in
            - finish the toString method
         
            - once thats done the next biggest thing is to start setting up the firebase functions to compare to face structure arrays to see their similarity and only create a match with users that have 50% or more facial similarity and test to see how it works out.
        */
    }
    
    init(eyeBrowWidth: Int) {
        self.eyeBrowWidth = eyeBrowWidth
        
    }
    
    private func getFeatureDistance(pointA: CGFloat, pointB: CGFloat) -> Int {
        return Int(pointA.distance(to: pointB))
    }
    
    func setEyebrowWidth(pointA: CGFloat, pointB: CGFloat, pointC: CGFloat, pointD: CGFloat) {
        let leftEyeBrowWidth = getFeatureDistance(pointA: pointA, pointB: pointB)
        let rightEyeBrowWidth = getFeatureDistance(pointA: pointC, pointB: pointD)
        self.eyeBrowWidth = (leftEyeBrowWidth + rightEyeBrowWidth) / 2
    }
    
    func setSpaceBetweenEyes(pointA: CGFloat, pointB: CGFloat) {
        self.spaceBetweenEyes = getFeatureDistance(pointA: pointA, pointB: pointB)
    }
    
    func toAnyObject() -> [String : AnyObject] {
        return ["eyeBrowWidth" : self.eyeBrowWidth as AnyObject, "spaceBetweenEyes" : self.spaceBetweenEyes as AnyObject, "eyeBrowWidth" : self.eyeBrowWidth as AnyObject]
    }
    
}

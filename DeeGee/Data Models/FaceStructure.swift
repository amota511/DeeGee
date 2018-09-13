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
    
    init(faceLandmarks: [CGPoint]) {
        
        
    }
    
    init(eyeBrowWidth: Int, spaceBetweenEyes: Int, eyeWidth: Int, eyeHeight: Int, noseWidth: Int, noseHeight: Int, nostrilWidth: Int, nostrilHeight: Int, topLipHeight: Int, bottomLipHeight: Int, lipWidth: Int, chinHeight: Int, chinWidth: Int, faceWidth: Int, faceHeight: Int) {
        
        self.eyeBrowWidth = eyeBrowWidth
        self.spaceBetweenEyes = spaceBetweenEyes
        self.eyeWidth = eyeWidth
        self.eyeHeight = eyeHeight
        self.noseWidth = noseWidth
        self.noseHeight = noseHeight
        self.nostrilWidth = nostrilWidth
        self.nostrilHeight = nostrilHeight
        self.topLipHeight = topLipHeight
        self.bottomLipHeight = bottomLipHeight
        self.lipWidth = lipWidth
        self.chinHeight = chinHeight
        self.chinWidth = chinWidth
        self.faceWidth = faceWidth
        self.faceHeight = faceHeight
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
    
    func setEyeWidth(pointA: CGFloat, pointB: CGFloat, pointC: CGFloat, pointD: CGFloat) {
        let leftEyeWidth = getFeatureDistance(pointA: pointA, pointB: pointB)
        let rightEyeWidth = getFeatureDistance(pointA: pointC, pointB: pointD)
        self.eyeWidth = (leftEyeWidth + rightEyeWidth) / 2
    }
    
    func setEyeHeight(pointA: CGFloat, pointB: CGFloat, pointC: CGFloat, pointD: CGFloat) {
        let leftEyeHeight = getFeatureDistance(pointA: pointA, pointB: pointB)
        let rightEyeHeight = getFeatureDistance(pointA: pointC, pointB: pointD)
        self.eyeHeight = (leftEyeHeight + rightEyeHeight) / 2
    }
    
    func setNoseWidth(pointA: CGFloat, pointB: CGFloat) {
        self.noseWidth = getFeatureDistance(pointA: pointA, pointB: pointB)
    }
    
    func setNoseHeight(pointA: CGFloat, pointB: CGFloat) {
        self.noseHeight = getFeatureDistance(pointA: pointA, pointB: pointB)
    }
    
    func setNostrilWidth(pointA: CGFloat, pointB: CGFloat, pointC: CGFloat, pointD: CGFloat) {
        let leftNostrilWidth = getFeatureDistance(pointA: pointA, pointB: pointB)
        let rightNostrilWidth = getFeatureDistance(pointA: pointC, pointB: pointD)
        self.nostrilWidth = (leftNostrilWidth + rightNostrilWidth) / 2
    }
    
    func setNostrilHeight(pointA: CGFloat, pointB: CGFloat, pointC: CGFloat, pointD: CGFloat) {
        let leftNostrilHeight = getFeatureDistance(pointA: pointA, pointB: pointB)
        let rightNostrilHeight = getFeatureDistance(pointA: pointC, pointB: pointD)
        self.nostrilHeight = (leftNostrilHeight + rightNostrilHeight) / 2
    }
    
    func setTopLipHeight(pointA: CGFloat, pointB: CGFloat) {
        self.topLipHeight = getFeatureDistance(pointA: pointA, pointB: pointB)
    }
    
    func setBottomLipHeight(pointA: CGFloat, pointB: CGFloat) {
        self.bottomLipHeight = getFeatureDistance(pointA: pointA, pointB: pointB)
    }
    
    func setLipWidth(pointA: CGFloat, pointB: CGFloat) {
        self.lipWidth = getFeatureDistance(pointA: pointA, pointB: pointB)
    }
    
    func setChinWidth(pointA: CGFloat, pointB: CGFloat) {
        self.chinWidth = getFeatureDistance(pointA: pointA, pointB: pointB)
    }
    
    func setChinHeight(pointA: CGFloat, pointB: CGFloat) {
        self.chinHeight = getFeatureDistance(pointA: pointA, pointB: pointB)
    }
    
    func setFaceWidth(pointA: CGFloat, pointB: CGFloat) {
        self.faceWidth = getFeatureDistance(pointA: pointA, pointB: pointB)
    }
    
    func setFaceHeight(pointA: CGFloat, pointB: CGFloat) {
        self.faceHeight = getFeatureDistance(pointA: pointA, pointB: pointB)
    }
    
    func toAnyObject() -> [String : AnyObject] {
        return ["eyeBrowWidth" : self.eyeBrowWidth as AnyObject, "spaceBetweenEyes" : self.spaceBetweenEyes as AnyObject, "eyeWidth" : self.eyeWidth as AnyObject, "eyeHeight" : self.eyeHeight as AnyObject, "noseWidth" : self.noseWidth as AnyObject, "noseHeight" : self.noseHeight as AnyObject, "nostrilWidth" : self.nostrilWidth as AnyObject, "nostrilHeight" : self.nostrilHeight as AnyObject, "topLipHeight" : self.topLipHeight as AnyObject, "bottomLipHeight" : self.bottomLipHeight as AnyObject, "lipWidth" : self.lipWidth as AnyObject, "chinHeight" : self.chinHeight as AnyObject, "chinWidth" : self.chinWidth as AnyObject, "faceWidth" : self.faceWidth as AnyObject, "faceHeight" : self.faceHeight as AnyObject]
    }
    
}

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

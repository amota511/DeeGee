//
//  ImageViewController.swift
//  DucTran-SnapchatCamera
//
//  Created by Duc Tran on 8/15/17.
//  Copyright © 2017 Duc Tran. All rights reserved.
//

import UIKit
import Vision

class ImageViewController : UIViewController
{
    var destinationImageView: UIImageView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    var faceStructurePoints = [CGPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        performFaceDetection()
    }
    
    @IBAction func closeButtonDidTap () {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func save(sender: UIButton) {
        guard let imageToSave = image else {
            return
        }
        //destinationImageView.image = imageToSave
        performSegue(withIdentifier: "unwindToRegister", sender: self)
    }
    
    func performFaceDetection() {
        print("inside function")
        //        imageView.image = imageView.image!.fixOrientation()!
        //        let img = imageView.image!.fixOrientation()!
        
        imageView.image = imageView.image!.fixOrientation()!.scaleImage(toSize: CGSize(width: 500, height: 500))
        imageView.contentMode = .scaleAspectFit
        let img = imageView.image!
        
        //let croppedcgimage = img.cgImage?.cropping(to: CGRect(origin: CGPoint(x: <#T##CGFloat#>, y: 0), size: CGSize(width: <#T##CGFloat#>, height: img.size.height)))
        print("img width: \(img.size.width) - ", "img height: \(img.size.height)")
        print("view width: \(view.frame.size.width) - ", "view height: \(view.frame.size.height)")
        let landmarkRequest = VNDetectFaceLandmarksRequest(completionHandler: { (req, err) in
            
            if let err = err {
                print("Failed to detect landmarks:", err)
                return
            }
            //0.2159974093
            //501
            req.results?.forEach({ (res) in
                print(res)
                guard let faceObservation = res as? VNFaceObservation else { return }
                //print("Landmarks:", faceObservation.landmarks!)
                let scaledHeight = self.view.frame.width / img.size.width * img.size.height
                let scaledWidth = self.imageView.frame.height / img.size.width * img.size.height
                //let scaledHeight = self.view.frame.height / img.size.width
                
                self.faceStructurePoints = faceObservation.landmarks!.allPoints!.normalizedPoints
                var count = 1    
                faceObservation.landmarks!.allPoints!.normalizedPoints.forEach({ (point) in
                    //.pointsInImage(imageSize: CGSize(width: scaledWidth, height: scaledHeight)).forEach({ (point) in
                        print("point \(count):", point.x, " ", point.y)
                    
                    
                        //let x = self.imageView.frame.width * point.x
                        //let y = scaledHeight * (1 - point.y) - 4
                    
                        let redView = UILabel()
                        redView.textColor = .red
                        redView.text = String(count)
                        redView.textAlignment = .center
                        redView.font = redView.font.withSize(8)
                        redView.frame = CGRect(x: point.x , y: self.imageView.frame.height - point.y , width: 15, height: 15)
                        //redView.layer.cornerRadius = redView.frame.size.height / 2
                        self.view.addSubview(redView)
                        count += 1
                })
            })
        })
        
        
        guard let cgimage = img.cgImage else { return }
        let lmHandler = VNImageRequestHandler(cgImage: cgimage, options: [:])
        do {
            try lmHandler.perform([landmarkRequest])
        } catch let errPerform {
            print("Failed to perform request: ", errPerform)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToRegister" {
            let registerVC = segue.destination as! RegisterVC
            registerVC.profilePhoto.image = imageView.image
            registerVC.faceStructurePoints = faceStructurePoints
            //imageViewController.destinationImageView = destinationImageView
        }
    }
}

extension UIImage {
    
    func fixOrientation() -> UIImage? {
        
        if (imageOrientation == .up) { return self }
        
        var transform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0.0)
            transform = transform.rotated(by: .pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0.0, y: size.height)
            transform = transform.rotated(by: -.pi / 2.0)
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: .pi)
        default:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
        default:
            break
        }
        
        guard let cgImg = cgImage else { return nil }
        
        if let context = CGContext(data: nil,
                                   width: Int(size.width), height: Int(size.height),
                                   bitsPerComponent: cgImg.bitsPerComponent,
                                   bytesPerRow: 0, space: cgImg.colorSpace!,
                                   bitmapInfo: cgImg.bitmapInfo.rawValue) {
            
            context.concatenate(transform)
            
            if imageOrientation == .left || imageOrientation == .leftMirrored ||
                imageOrientation == .right || imageOrientation == .rightMirrored {
                context.draw(cgImg, in: CGRect(x: 0.0, y: 0.0, width: size.height, height: size.width))
            } else {
                context.draw(cgImg, in: CGRect(x: 0.0 , y: 0.0, width: size.width, height: size.height))
            }
            
            if let contextImage = context.makeImage() {
                return UIImage(cgImage: contextImage)
            }
            
        }
        
        return nil
    }
    
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
    
}


















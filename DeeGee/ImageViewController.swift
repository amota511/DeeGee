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
        destinationImageView.image = imageToSave
        performSegue(withIdentifier: "unwindToRegister", sender: self)
    }
    
    func performFaceDetection() {
        print("inside function")
        let img = imageView.image!.fixOrientation()!
        
        let landmarkRequest = VNDetectFaceLandmarksRequest(completionHandler: { (req, err) in
            
            if let err = err {
                print("Failed to detect landmarks:", err)
                return
            }
            
            req.results?.forEach({ (res) in
                print(res)
                guard let faceObservation = res as? VNFaceObservation else { return }
                print("Landmarks:", faceObservation.landmarks!)

                faceObservation.landmarks!.allPoints!.pointsInImage(imageSize: CGSize(width: self.imageView.frame.size.width * 1.3, height: self.imageView.frame.size.height) ).forEach({ (point) in
                    
                    let redView = UIView()
                    redView.backgroundColor = .red
                    redView.frame = CGRect(x: point.x - self.imageView.frame.size.width * 0.16, y: self.imageView.frame.height - point.y, width: 4, height: 4)
                    self.view.addSubview(redView)
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
    
}


















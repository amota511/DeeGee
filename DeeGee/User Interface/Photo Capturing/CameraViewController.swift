//
//  CameraViewController.swift
//  DucTran-SnapchatCamera
//
//  Created by Duc Tran on 8/15/17.
//  Copyright © 2017 Duc Tran. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController : UIViewController
{
    var destinationImageView: UIImageView!
    
    let grayLoadingView = UIView()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    @IBOutlet weak var cameraButton: UIButton!
    var captureSession = AVCaptureSession()
    
    // which camera input do we want to use
    var backFacingCamera: AVCaptureDevice?
    var frontFacingCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    
    // output device
    var stillImageOutput: AVCaptureStillImageOutput?
    var stillImage: UIImage?
    
    // camera preview layer
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grayLoadingView.backgroundColor = UIColor.black
        grayLoadingView.frame = self.view.frame
        grayLoadingView.alpha = 0.65
        
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as! [AVCaptureDevice]
        for device in devices {
            if device.position == .back {
                backFacingCamera = device
            } else if device.position == .front {
                frontFacingCamera = device
            }
        }
        
        // default device
        currentDevice = frontFacingCamera
        
        // configure the session with the output for capturing our still image
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
            
            captureSession.addInput(captureDeviceInput)
            captureSession.addOutput(stillImageOutput)
            
            // set up the camera preview layer
            cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            view.layer.addSublayer(cameraPreviewLayer!)
            cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            cameraPreviewLayer?.frame = view.layer.frame
            
            view.bringSubview(toFront: cameraButton)
            
            captureSession.startRunning()

        } catch let error {
            print(error)
        }
    }
    
    @objc private func toggleCamera() {
        // start the configuration change
        captureSession.beginConfiguration()
        
        let newDevice = (currentDevice?.position == . back) ? frontFacingCamera : backFacingCamera
        
        for input in captureSession.inputs {
            captureSession.removeInput(input as! AVCaptureDeviceInput)
        }
        
        let cameraInput: AVCaptureDeviceInput
        do {
            cameraInput = try AVCaptureDeviceInput(device: newDevice)
        } catch let error {
            print(error)
            return
        }
        
        if captureSession.canAddInput(cameraInput) {
            captureSession.addInput(cameraInput)
        }
        
        currentDevice = newDevice
        captureSession.commitConfiguration()
    }
    
    @IBAction func shutterButtonDidTap()
    {
        //place loading UI
        placeLoadingUI()
        
        let videoConnection = stillImageOutput?.connection(withMediaType: AVMediaTypeVideo)

        // capture a still image asynchronously
        stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (imageDataBuffer, error) in

            if let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: imageDataBuffer!, previewPhotoSampleBuffer: imageDataBuffer!) {
                self.stillImage = UIImage(data: imageData)
                self.performSegue(withIdentifier: "showPhoto", sender: self)
            }
        })
    }
    
    func placeLoadingUI() {
        self.view.addSubview(grayLoadingView)
            
        // Add it to the view where you want it to appear
        self.view.addSubview(activityIndicator)
        
        // Set up its size (the super view bounds usually)
        activityIndicator.frame = view.bounds
        
        // Start the loading animation
        activityIndicator.startAnimating()
        
    }
    
    func removeLoadingUI() {
        grayLoadingView.removeFromSuperview()
        activityIndicator.removeFromSuperview()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            //remove spinner
            removeLoadingUI()
            let imageViewController = segue.destination as! ImageViewController
            imageViewController.image = self.stillImage
            imageViewController.destinationImageView = destinationImageView
            printOrientation()
        }
    }
    
    func printOrientation() {
        
        var orientation = ""
        
        if stillImage!.imageOrientation == .down {
            orientation = "down"
        } else if stillImage!.imageOrientation == .downMirrored {
            orientation = "downMirrored"
        } else if stillImage!.imageOrientation == .leftMirrored {
            orientation = "leftMirrored"
        } else if stillImage!.imageOrientation == .left {
            orientation = "left"
        } else if stillImage!.imageOrientation == .right {
            orientation = "right"
        } else if stillImage!.imageOrientation == .rightMirrored {
            orientation = "rightMirrored"
        } else if stillImage!.imageOrientation == .up {
            orientation = "up"
        } else if stillImage!.imageOrientation == .upMirrored {
            orientation = "upMirrored"
        }
        
        print("Orientation \(orientation)")
    }
}



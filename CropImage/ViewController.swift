//
//  ViewController.swift
//  CropImage
//
//  Created by Anirudha on 14/12/17.
//  Copyright © 2017 Anirudha Mahale. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var captureSession = AVCaptureSession()
    var previewLayer: CALayer!
    var captureDevice: AVCaptureDevice!
    
    var takePhoto = false
    var takenPhoto = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareCamera()
    }
    
    private func prepareCamera() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        if #available(iOS 10.0, *) {
            let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.back).devices
            if let firstDevice = availableDevices.first {
                captureDevice = firstDevice
                beginSession()
            }
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func beginSession() {
        do {
            // This will ask the user for the permission, until the user clicks the allow the camera will the input of black stream.
            // Still we can first ask for the permission and then come here if authorized.
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print("Error while begining the session:\n  \(error.localizedDescription)")
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = previewLayer
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.layer.frame
        self.captureSession.startRunning()
        
        // Create data output to show on the camera
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): NSNumber(value: kCVPixelFormatType_32BGRA)]
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
         captureSession.commitConfiguration()
    }
    
    func getFrameSize() {
        // 1) Get the width and height of the image.
        // 2) Get the midY of the image
        // 3) y = midY - ((width - 40 ) /2)
        // 4) x = 20
        // 5) width = width - 40
        // 6) height = width
    }
    
    @IBAction func ClickTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "PushImageViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PushImageViewController" {
            if let vc = segue.destination as? ImageViewController {
                vc.imageView.image = takenPhoto
            }
        }
    }

}


//
//  MugshotController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 10/6/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import AVFoundation
import UIKit
import AFNetworking
import Parse
import ParseFacebookUtilsV4

class MugshotController: UIViewController {
  @IBOutlet weak var profileImage: UIImageView!

  let user = User.currentUser()
  
  override func viewDidLoad() {
    if let id = user?.authData?["facebook"]?["id"] as? String {
      profileImage.setImageWithURL(NSURL(string: "https://graph.facebook.com/\(id)/picture?type=large")!,
        placeholderImage: UIImage(named: "thunderdome"))
    }
  }
  
  @IBAction func doneTapped(sender: AnyObject) {
    if let user = user {
      let imageData = NSData(data: UIImageJPEGRepresentation(profileImage.image!, 0.9)!)
      user.avatar = PFFile(data: imageData)
      user.saveInBackground()
    }
    let main = UIStoryboard(name: "Main", bundle: nil)
    let vc = main.instantiateInitialViewController()!
    presentViewController(vc, animated: true, completion: nil)
  }
  
  @IBAction func chooseTapped(sender: AnyObject) {
    var device: AVCaptureDevice! = nil
    let session = AVCaptureSession()
    session.sessionPreset = AVCaptureSessionPresetPhoto
    
    // Get the front camera
    let devices = AVCaptureDevice.devices()
    for d in devices {
      if !d.hasMediaType(AVMediaTypeVideo) {
        continue
      }
      if d.position == AVCaptureDevicePosition.Front {
        device = d as! AVCaptureDevice
      }
    }
    if device == nil {
      NSLog("Unable to find an appropriate camera")
      device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    }
    
    // Set up the output receiver
    let output = AVCaptureStillImageOutput()
    output.outputSettings = [ AVVideoCodecKey : AVVideoCodecJPEG ]
    session.addOutput(output)
    
    // Start using the camera we found
    do {
      try session.addInput(AVCaptureDeviceInput(device: device))
    } catch {
      NSLog("Error setting capture input: \(error)")
      return
    }
    let preview = AVCaptureVideoPreviewLayer(session: session)
    preview.frame = profileImage.bounds
    profileImage.layer.addSublayer(preview)
    session.startRunning()
    
  }
}

//
//  SignupController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse

class SignupController: AuthController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  var user: User!

  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    dismissViewControllerAnimated(false, completion: nil)
    let jpeg = UIImageJPEGRepresentation(image, 0.8)!
    user.avatar = PFFile(data: jpeg, contentType: "image/jpeg")
    user.saveEventually()
    
    performSegueWithIdentifier("segue.launch", sender: self)
  }
  
  override func doAuth(username: String, password: String) {
    user = User()
    user.username = username
    user.password = password
    user.signUpInBackgroundWithBlock { (success, error) -> Void in
      if success {
        self.requestProfilePhoto()
      } else {
        NSLog("Failed to sign up:\n\(error!.description)")
      }
    }
  }
  
  private func requestProfilePhoto() {
    let vc = UIImagePickerController()
    vc.sourceType = .PhotoLibrary
    vc.delegate = self
    presentViewController(vc, animated: true, completion: nil)
  }
}

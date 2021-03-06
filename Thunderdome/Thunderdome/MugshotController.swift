//
//  MugshotController.swift
//  Thunderdome
//
//  Created by Patrick Stein on 10/6/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import AFNetworking
import Parse
import ParseFacebookUtilsV4

class MugshotController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var doneButton: UIButton!
  @IBOutlet weak var userView: UserView!

  let user = User.currentUser()
  
  override func viewDidLoad() {
    setupDoneButton()
    
    userView.user = user
    
    let defaultImage = UIImage(named: "default-avatar")
    if let id = user?.authData?["facebook"]?["id"] as? String {
      userView.avatarImage.setImageWithURL(NSURL(string: "https://graph.facebook.com/\(id)/picture?type=large")!,
        placeholderImage: defaultImage)
    } else {
      userView.avatarImage.image = defaultImage
    }
  }
  
  @IBAction func doneTapped(sender: AnyObject) {
    if let user = user {
      let imageData = NSData(data: UIImageJPEGRepresentation(userView.avatarImage.image!, 0.9)!)
      user.avatar = PFFile(data: imageData)
      user.saveInBackground()
    }
    let main = UIStoryboard(name: "Main", bundle: nil)
    let vc = main.instantiateInitialViewController()!
    presentViewController(vc, animated: true, completion: nil)
  }
  
  @IBAction func chooseTapped(sender: AnyObject) {
    pickImage(.SavedPhotosAlbum)
  }
  
  @IBAction func takePhotoTapped(sender: AnyObject) {
    pickImage(.Camera)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    userView.avatarImage.image = image
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func viewDidLayoutSubviews() {
    
  }
  
  private func pickImage(type: UIImagePickerControllerSourceType) {
    if !UIImagePickerController.isSourceTypeAvailable(type) {
      NSLog("Unsupported source type")
      return
    }
    
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.sourceType = type
    picker.allowsEditing = true
    
    presentViewController(picker, animated: true, completion: nil)
  }
  
  private func setupDoneButton() {
    doneButton.backgroundColor = doneButton.titleColorForState(.Normal)
    doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
  }
}

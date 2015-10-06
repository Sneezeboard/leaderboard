//
//  MugshotController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 10/6/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import AFNetworking
import Parse
import ParseFacebookUtilsV4

class MugshotController: UIViewController {
  @IBOutlet weak var profileImage: UIImageView!

  let user = User.currentUser()!
  
  override func viewDidLoad() {
    if let id = user.authData?["facebook"]?["id"] as? String {
      profileImage.setImageWithURL(NSURL(string: "https://graph.facebook.com/\(id)/picture?type=large")!,
        placeholderImage: UIImage(named: "thunderdome"))
    }
  }
  
  @IBAction func doneTapped(sender: AnyObject) {
    let imageData = NSData(data: UIImageJPEGRepresentation(profileImage.image!, 0.9)!)
    user.avatar = PFFile(data: imageData)
    user.saveInBackground()
    
    let main = UIStoryboard(name: "Main", bundle: nil)
    let vc = main.instantiateInitialViewController()!
    presentViewController(vc, animated: true, completion: nil)
  }
  
  @IBAction func chooseTapped(sender: AnyObject) {
  }
}

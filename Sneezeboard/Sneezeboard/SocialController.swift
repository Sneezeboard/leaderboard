//
//  SocialController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class SocialController: UIViewController {
  @IBOutlet weak var facebookButton: UIButton!
  @IBOutlet weak var skipButton: UIBarButtonItem!

  @IBAction func facebookTouched(sender: AnyObject) {
    if !PFFacebookUtils.isLinkedWithUser(User.currentUser()!) {
      PFFacebookUtils.linkUserInBackground(User.currentUser()!, withReadPermissions: nil, block: { (success, error) -> Void in
        if success {
          self.skipButton.title = "Next"
          self.facebookButton.enabled = false
          self.facebookButton.backgroundColor = UIColor.lightGrayColor()
        } else {
          if let error = error {
            let alert = UIAlertController(title: "No Bueno", message: (error.userInfo["error"] as! String), preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
              // Do nothing
            }))
            self.presentViewController(alert, animated: true, completion: nil)
          }
          NSLog("Unable to link Facebook:\n\(error?.description)")
        }
      })
    }
  }
}
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

class SocialController: UIViewController, LeaguePickerProtocol {
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let nav = segue.destinationViewController as? UINavigationController {
      if let vc = nav.childViewControllers[0] as? LeaguePickerController {
        vc.owner = self
      }
    }
  }
  
  @IBAction func facebookTouched(sender: AnyObject) {
    if !PFFacebookUtils.isLinkedWithUser(User.currentUser()!) {
      PFFacebookUtils.linkUserInBackground(User.currentUser()!, withReadPermissions: nil, block: { (success, error) -> Void in
        if success {
          
        } else {
          NSLog("Unable to link Facebook:\n\(error?.description)")
        }
      })
    }
  }
  
  func donePickingLeagues() {
    dismissViewControllerAnimated(false) { () -> Void in
      self.performSegueWithIdentifier("segue.launch", sender: self)
    }
  }
}
//
//  SocialController.swift
//  Thunderdome
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class SocialController: UIViewController {
  @IBOutlet weak var facebookButton: UIButton!
  @IBOutlet weak var skipButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    addBorderToSkipButton()
  }
  
  @IBAction func facebookTouched(sender: AnyObject) {
    if !PFFacebookUtils.isLinkedWithUser(User.currentUser()!) {
      PFFacebookUtils.linkUserInBackground(User.currentUser()!, withReadPermissions: nil, block: { (success, error) -> Void in
        if success {
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
  
  private func addBorderToSkipButton() {
    let color = skipButton.titleColorForState(.Normal)!
    let border = CALayer()
    border.frame = CGRectMake(0, 0, skipButton.bounds.width, 1)
    border.backgroundColor = color.CGColor
    skipButton.layer.addSublayer(border)
  }
}

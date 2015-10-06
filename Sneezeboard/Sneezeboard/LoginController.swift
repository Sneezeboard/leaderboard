//
//  LoginController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class LoginController: AuthController {
  @IBAction func backTouched(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func doAuth(username: String, password: String) {
    User.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
      if let error = error {
        NSLog("Unable to log in:\n\(error.description)")
      } else {
        self.performSegueWithIdentifier("segue.login.launch", sender: self)
      }
    }
  }
}

//
//  SignupController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse

class SignupController: AuthController {
  var user: User!
  
  override func doAuth(username: String, password: String) {
    user = User()
    user.username = username
    user.password = password
    user.signUpInBackgroundWithBlock { (success, error) -> Void in
      if success {
        self.finish("segue.signup.next")
      } else {
        let alert = UIAlertController(title: "No Bueno", message: "Bad credentials", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
          // Do nothing
        }))
        self.presentViewController(alert, animated: true, completion: nil)
      }
    }
  }
}

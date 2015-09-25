//
//  LoginController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!

  @IBAction func backTouched(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func loginTouched(sender: AnyObject) {
    doLogin()
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    doLogin()
    return true
  }
  
  private func doLogin() {
    User.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user, error) -> Void in
      if let error = error {
        NSLog("Unable to log in:\n\(error.description)")
      } else {
        self.performSegueWithIdentifier("segue.login.social", sender: self)
      }
    }
  }
}

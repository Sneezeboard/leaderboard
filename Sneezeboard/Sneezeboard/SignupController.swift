//
//  SignupController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class SignupController: UIViewController, UITextFieldDelegate {
  @IBOutlet weak var usernameField: UITextField!
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    doSignup()
    return true
  }
  
  @IBAction func signupTouched(sender: AnyObject) {
    doSignup()
  }
  
  private func doSignup() {
    let user = User()
    user.username = usernameField.text
    user.password = makePassword()
    user.signUpInBackgroundWithBlock { (success, error) -> Void in
      if success {
        self.performSegueWithIdentifier("segue.signup.social", sender: self)
      } else {
        NSLog("Failed to sign up:\n\(error!.description)")
      }
    }
  }
  
  private func makePassword() -> String {
    return "abc123" // Dear god someone fix me
  }
}

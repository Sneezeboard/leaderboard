//
//  AuthController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 10/5/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class AuthController: UIViewController, UITextFieldDelegate {
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup buttons
    setupButton(usernameField)
    setupButton(passwordField)
    usernameField.delegate = self
    passwordField.delegate = self
    
    // Autoscroll the view when the keyboard opens
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardHidden:", name: UIKeyboardWillHideNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardShown:", name: UIKeyboardWillShowNotification, object: nil)
  }

  @IBAction func triggerAuth() {
    doAuth(usernameField.text ?? "", password: passwordField.text ?? "")
  }
  
  func doAuth(username: String, password: String) {
    // To be implemented by subclass
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if (textField != passwordField) {
      return true
    }
    
    triggerAuth()
    return true
  }
  
  func keyboardShown(notification: NSNotification) {
    if let raw = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardFrame = raw.CGRectValue()
    
      UIView.animateWithDuration(0.5) { () -> Void in
        self.view.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.height)
      }
    }
  }
  func keyboardHidden(notification: NSNotification) {
    UIView.animateWithDuration(0.5) { () -> Void in
      self.view.transform = CGAffineTransformIdentity
    }
  }
  
  private func setupButton(field: UITextField) {
    let color = UIColor(white: 1.0, alpha: 0.9)
    let border = CALayer()
    border.frame = CGRectMake(0, field.bounds.height - 1, field.bounds.width, 1)
    border.backgroundColor = color.CGColor
    field.layer.addSublayer(border)
    field.textColor = color
    field.attributedPlaceholder = NSAttributedString(string: field.placeholder ?? "", attributes: [
      NSForegroundColorAttributeName : UIColor(white: 1.0, alpha: 0.6)
    ])
  }

}
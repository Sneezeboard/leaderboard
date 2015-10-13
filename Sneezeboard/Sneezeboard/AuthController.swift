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
  @IBOutlet weak var titleText: UILabel!
  @IBOutlet weak var topConstraint: NSLayoutConstraint!
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  
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

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    let f: () -> Void = { () -> Void in
      self.transformSubviews(200)
    }
    if animated {
      UIView.animateWithDuration(0.5, animations: f)
    } else {
      f()
    }
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    let f: () -> Void = { () -> Void in
      self.transformSubviews(0)
    }
    if animated {
      UIView.animateWithDuration(0.5, animations: f)
    } else {
      f()
    }
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
    
      self.view.layoutIfNeeded()
      UIView.animateWithDuration(0.5) { () -> Void in
        self.topConstraint.constant = -70
        self.bottomConstraint.constant = keyboardFrame.height
        self.view.layoutIfNeeded()
      }
    }
  }
  func keyboardHidden(notification: NSNotification) {
    UIView.animateWithDuration(0.5) { () -> Void in
      self.topConstraint.constant = 0
      self.bottomConstraint.constant = 0
      self.view.layoutIfNeeded()
    }
  }
  
  private func transformSubviews(x: CGFloat) {
    let mat = CGAffineTransformMakeTranslation(x, 0)
    for view in self.view.subviews {
      for v in view.subviews {
        v.transform = mat
      }
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
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
  
  override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
    if let _ = fromViewController as? AuthController {
      let segue = InPlaceSegue(identifier: identifier, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
        
      })
      segue.unwind = true
      return segue
    }
    
    return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)
  }
  
  func slideOut(completion: (() -> Void)?) {
    transformSubviews(-view.bounds.width, animated: true, completion: completion)
  }
  
  func slideIn(completion: (() -> Void)?) {
    transformSubviews(view.bounds.width, animated: false, completion: nil)
    transformSubviews(0, animated: true, completion: completion)
  }
  
  @IBAction func triggerAuth() {
    doAuth(usernameField.text ?? "", password: passwordField.text ?? "")
  }
  
  @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
    
  }
  
  func finish(segue: String) {
    // We need to animate the title text based on it's top left, but once
    // we change the anchorpoint it'll shift in the view.  The translation is
    // used to correct this.
    titleText.layer.anchorPoint = CGPointMake(0, 0)
    titleText.layer.transform = CATransform3DMakeTranslation(titleText.layer.bounds.width / -2, titleText.layer.bounds.height / -2, 0)

    // Set up a layer transform.  This won't screw with the auto layer, and
    // makes it easy to customize the ease curve.
    let rotateAnim = CABasicAnimation(keyPath: "transform")
    rotateAnim.fillMode = kCAFillModeForwards
    rotateAnim.removedOnCompletion = false
    rotateAnim.duration = 0.4
    rotateAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.06, 1.82, 0.55, 0.80)
    rotateAnim.toValue = NSValue(CATransform3D: CATransform3DRotate(titleText.layer.transform, CGFloat(M_PI_2) - 0.2, 0, 0, 1))
    titleText.layer.addAnimation(rotateAnim, forKey: nil)
    
    // Once the text is done rotating, slide the whole thing down
    let options = UIViewAnimationOptions.CurveEaseIn
    UIView.animateWithDuration(0.3, delay: 0.2, options: options, animations: { () -> Void in
      self.topConstraint.constant = self.view.bounds.height * 0.75
      self.view.layoutIfNeeded()
    }, completion: nil)
    
    // Overlap a fade with the translation, as a slighty-hacky way to tidy
    // everything up
    UIView.animateWithDuration(0.2, delay: 0.3, options: options, animations: { () -> Void in
      for v in self.view.subviews {
        v.alpha = 0
      }
    }) { (_) -> Void in
      if segue != "" {
        self.performSegueWithIdentifier(segue, sender: self)
      }
    }
  }
  
  func doAuth(username: String, password: String) {
    // To be implemented by subclass
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if (textField == usernameField) {
      passwordField.becomeFirstResponder()
    } else if (textField == passwordField) {
      triggerAuth()
    }
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
  
  private func transformSubviews(x: CGFloat, animated: Bool, completion: (() -> Void)?) {
    let mat = CGAffineTransformMakeTranslation(x, 0)
    
    let f: () -> Void = { () -> Void in
      self.transformSubviews(mat)
      self.titleText.transform = mat
    }
    if animated {
      let curve = x < 0 ? UIViewAnimationOptions.CurveEaseOut : UIViewAnimationOptions.CurveEaseIn
      UIView.animateWithDuration(0.3, delay: 0, options: curve, animations: f, completion: { (_) -> Void in
        completion?()
      })
    } else {
      f()
      completion?()
    }
  }
  
  private func transformSubviews(mat: CGAffineTransform) {
    for view in self.view.subviews {
      for v in view.subviews {
        v.transform = mat
      }
    }
    titleText.transform = mat
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
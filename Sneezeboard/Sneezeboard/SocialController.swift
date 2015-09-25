//
//  SocialController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class SocialController: UIViewController, LeaguePickerProtocol {
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let nav = segue.destinationViewController as? UINavigationController {
      if let vc = nav.childViewControllers[0] as? LeaguePickerController {
        vc.owner = self
      }
    }
  }
  
  func donePickingLeagues() {
    dismissViewControllerAnimated(false) { () -> Void in
      self.performSegueWithIdentifier("segue.launch", sender: self)
    }
  }
}
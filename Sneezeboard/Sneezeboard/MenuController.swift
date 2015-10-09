//
//  MenuController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 10/8/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

  @IBAction func signOutTapped(sender: AnyObject) {
    UIApplication.sharedApplication().windows[0].rootViewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController()
  }
}

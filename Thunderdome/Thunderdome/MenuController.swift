//
//  MenuController.swift
//  Thunderdome
//
//  Created by Patrick Stein on 10/8/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import RESideMenu

class MenuController: UIViewController, RESideMenuDelegate {

  @IBAction func signOutTapped(sender: AnyObject) {    
    if let parent = parentViewController as? RESideMenu {
      parent.delegate = self
      parent.hideMenuViewController()
    } else {
      finishLogout()
    }
  }
  
  func sideMenu(sideMenu: RESideMenu!, didHideMenuViewController menuViewController: UIViewController!) {
    finishLogout()
  }
  
  private func finishLogout() {
    User.logOut()
    let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController()
    let window = UIApplication.sharedApplication().windows[0]
    
    UIView.transitionWithView(window, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
      window.rootViewController = vc
    }) { (_) -> Void in
      
    }
  }
}

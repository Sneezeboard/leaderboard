//
//  RootController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 10/7/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import RESideMenu
import ESTabBarController

class RootController: UIViewController {
  let tabBar = ESTabBarController(tabIconNames: ["thunderdome", "thunderdome", "thunderdome"])
  var menuController: UIViewController!
  var mainController: RESideMenu!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    menuController = storyboard?.instantiateViewControllerWithIdentifier("vc.menu")
    mainController = RESideMenu(contentViewController: tabBar, leftMenuViewController: menuController, rightMenuViewController: nil)
    
    for i in 0..<3 {
      addViewController(i)
    }
    tabBar.highlightButtonAtIndex(1)
    // tabBar.selectedColor = UIColor.redColor()
    // tabBar.buttonsBackgroundColor = UIColor.blueColor()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    presentViewController(mainController, animated: false, completion: nil)
  }
  
  func openMenu() {
    mainController.presentLeftMenuViewController()
  }
  
  private func addViewController(index: Int) {
    let vc = storyboard?.instantiateViewControllerWithIdentifier("vc.\(index)")
    tabBar.setViewController(vc, atIndex: index)
    
    if let vc = vc as? UINavigationController {
      let button = UIBarButtonItem(title: "⚙", style: .Plain, target: self, action: "openMenu")
      vc.childViewControllers[0].navigationItem.leftBarButtonItem = button
    }
  }
}
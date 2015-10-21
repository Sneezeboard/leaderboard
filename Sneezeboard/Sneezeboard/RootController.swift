//
//  RootController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 10/7/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import RESideMenu
import RAMAnimatedTabBarController

class RootController: UIViewController {
  var menuController: UIViewController!
  var tabBar: UITabBarController!
  var mainController: RESideMenu!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    setupTabBar()
    menuController = storyboard?.instantiateViewControllerWithIdentifier("vc.menu")
    menuController.view.backgroundColor = UIColor.clearColor() // Design is black for visibility, clear it
    mainController = RESideMenu(contentViewController: tabBar, leftMenuViewController: menuController, rightMenuViewController: nil)
    mainController.backgroundImage = UIImage(named: "dark-texture")
    addChildViewController(mainController)
    view.addSubview(mainController.view)
    mainController.view.frame = view.bounds
    mainController.didMoveToParentViewController(self)
  }
  
  func openMenu() {
    mainController.presentLeftMenuViewController()
  }
  
  private func setupTabBar() {
    tabBar = storyboard?.instantiateViewControllerWithIdentifier("vc.tabs") as! UITabBarController
    
    let vcs = [
      storyboard!.instantiateViewControllerWithIdentifier("vc.0"),
      storyboard!.instantiateViewControllerWithIdentifier("vc.1"),
      storyboard!.instantiateViewControllerWithIdentifier("vc.2")
    ]
    for vc in vcs {
      if let image = vc.tabBarItem?.image {
        let scaled = scaleImage(image, size: 30)
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        vc.tabBarItem!.image = scaled
        vc.tabBarItem!.selectedImage = scaled
        vc.tabBarItem.title = ""
      }
      
      if let vc = vc as? UINavigationController {
        let button = UIBarButtonItem(title: "⚙", style: .Plain, target: self, action: "openMenu")
        vc.childViewControllers[0].navigationItem.leftBarButtonItem = button
      }
    }

    let blur = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
    blur.frame = tabBar.tabBar.bounds
    tabBar.viewControllers = vcs
    tabBar.tabBar.barTintColor = UIColor.whiteColor() // UIColor(red: 255 / 255.0, green: 94 / 255.0, blue: 85 / 255.0, alpha: 1)
    tabBar.tabBar.tintColor = UIColor(red: 248 / 255.0, green: 70 / 255.0, blue: 72 / 255.0, alpha: 1)//UIColor.whiteColor()
    tabBar.tabBar.backgroundImage = UIImage()
    tabBar.tabBar.translucent = true
    tabBar.tabBar.shadowImage = UIImage()
    tabBar.tabBar.insertSubview(blur, atIndex: 0)
    
    let border = UIView(frame: CGRectMake(0, 0, tabBar.tabBar.bounds.width, 2))
    border.backgroundColor = UIColor(red: 248 / 255.0, green: 70 / 255.0, blue: 72 / 255.0, alpha: 1)
    tabBar.tabBar.addSubview(border)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    tabBar.selectedIndex = 0
  }
  
  private func scaleImage(image: UIImage, size: CGFloat) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), false, 0.0)
    image.drawInRect(CGRectMake(0, 0, size, size))
    let scaled = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return scaled
  }
}
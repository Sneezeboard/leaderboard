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
        let scaled = scaleImage(image, size: vc.tabBarItem!.title == "Record" ? 50 : 30)
        vc.tabBarItem.imageInsets.bottom = 10.0
        vc.tabBarItem!.image = scaled
        vc.tabBarItem!.selectedImage = scaled
        
        if vc.tabBarItem!.title == "Record" {
          vc.tabBarItem.title = ""
        }
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
    tabBar.tabBar.tintColor = UIColor(red: 255 / 255.0, green: 94 / 255.0, blue: 85 / 255.0, alpha: 1)//UIColor.whiteColor()
    tabBar.tabBar.backgroundImage = UIImage()
    tabBar.tabBar.translucent = true
    tabBar.tabBar.shadowImage = UIImage()
    tabBar.tabBar.insertSubview(blur, atIndex: 0)
    
    let middleView = tabBar.tabBar.subviews[1]
    middleView.layer.cornerRadius = 30.0
    middleView.clipsToBounds = true
    
    let cover = UIView()
    cover.frame = CGRectMake(0, 0, 70, 70)
    cover.layer.cornerRadius = cover.frame.width / 2
    cover.clipsToBounds = true
    cover.backgroundColor = tabBar.tabBar.barTintColor
    cover.translatesAutoresizingMaskIntoConstraints = false
    tabBar.view.insertSubview(cover, atIndex: 2)
    cover.addConstraint(NSLayoutConstraint(
      item: cover,
      attribute: NSLayoutAttribute.Height,
      relatedBy: NSLayoutRelation.Equal,
      toItem: nil,
      attribute: NSLayoutAttribute.NotAnAttribute,
      multiplier: 1.0,
      constant: cover.frame.height
    ))
    cover.addConstraint(NSLayoutConstraint(
      item: cover,
      attribute: NSLayoutAttribute.Width,
      relatedBy: NSLayoutRelation.Equal,
      toItem: nil,
      attribute: NSLayoutAttribute.NotAnAttribute,
      multiplier: 1.0,
      constant: cover.frame.width
      ))
    tabBar.view.addConstraint(NSLayoutConstraint(
      item: cover,
      attribute: NSLayoutAttribute.CenterX,
      relatedBy: NSLayoutRelation.Equal,
      toItem: tabBar.view,
      attribute: NSLayoutAttribute.CenterX,
      multiplier: 1.0,
      constant: 0.0)
    )
    tabBar.view.addConstraint(NSLayoutConstraint(
      item: cover,
      attribute: NSLayoutAttribute.Bottom,
      relatedBy: NSLayoutRelation.Equal,
      toItem: tabBar.view,
      attribute: NSLayoutAttribute.Bottom,
      multiplier: 1.0,
      constant: 5.0)
    )
    tabBar.view.layoutSubviews()
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
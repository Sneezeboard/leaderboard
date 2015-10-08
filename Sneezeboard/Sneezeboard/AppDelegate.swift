//
//  AppDelegate.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {    
    setupParse(launchOptions)
    pickLaunchStoryboard()
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    FBSDKAppEvents.activateApp()
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
  }
  
  private func pickLaunchStoryboard() {
    var storyboard: UIStoryboard! = nil
    if let _ = User.currentUser() {
      storyboard = UIStoryboard(name: "Main", bundle: nil)
    } else {
      storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
    }
    window?.rootViewController = storyboard.instantiateInitialViewController()
  }
    
  private func setupParse(launchOptions: [NSObject: AnyObject]?) {
    User.registerSubclass()
    Sport.registerSubclass()
    Leaderboard.registerSubclass()
    Match.registerSubclass()
    Parse.setApplicationId("JTmtYRYHh6qDkgtwPHIgHWfsSx4TmMp6TFQqTlBN", clientKey: "EPS17m0XEpJtWf45AfhdZ0zmQvrhtCWS7WrY8LcZ")
    PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
    
//    do {
//        try Sport.createSomeSports()
//    } catch {
//        
//    }
  }
}


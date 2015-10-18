//
//  RecordMatchViewController.swift
//  Sneezeboard
//
//  Created by Cedric Han on 10/1/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class RecordMatchViewController: UIViewController {
    
    var match: Match!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        match.score1 = 9
        match.score2 = 11
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveMatch() {
        match.saveInBackgroundWithBlock { (success, error) -> Void in
            guard error == nil else {
                // show error
                return
            }
            
            if success {
                // Switch to the Activity view.
                if let
                    tabBarController = self.tabBarController,
                    navigationController = tabBarController.viewControllers?.first as? UINavigationController,
                    activityFeedViewController = navigationController.viewControllers.first as? ActivityFeedViewController
                {
                    self.performSegueWithIdentifier("segue.unwind_to_root", sender: self)
                    
                    activityFeedViewController.addCompletedMatch(self.match)
                    tabBarController.selectedIndex = 0
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

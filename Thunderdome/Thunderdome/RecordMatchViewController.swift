//
//  RecordMatchViewController.swift
//  Thunderdome
//
//  Created by Cedric Han on 10/1/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import ParseUI

class RecordMatchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var user1View: UserView!
    @IBOutlet weak var user2View: UserView!
    
    var match: Match!
    var scores: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]


    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var scorePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        doneButton.backgroundColor = doneButton.titleColorForState(.Normal)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
      
        self.scorePicker.dataSource = self
        self.scorePicker.delegate = self
      
        user1View.user = match.user1
        user2View.user = match.user2      
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 11
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.scores[row])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row); component: \(component)")
        if (component == 0) {
            match.score1 = scores[row]
        } else {
            match.score2 = scores[row]
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

//
//  OpponentTypesViewController.swift
//  Sneezeboard
//
//  Created by Cedric Han on 9/29/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import ParseUI

class OpponentTypesViewController: UIViewController {
    
    @IBOutlet weak var user1ImageView: PFImageView!
    @IBOutlet weak var user1NameLabel: UILabel!
    @IBOutlet weak var user2ImageView: PFImageView!
    @IBOutlet weak var user2NameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        user1NameLabel.text = User.currentUser()?.username
        user1ImageView.file = User.currentUser()?.avatar
        user1ImageView.loadInBackground()

        user2NameLabel.text = "???"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destinationViewController = segue.destinationViewController
        
        if let identifier = segue.identifier {
            switch identifier {
            case "segue.opponents.recent":
                let destinationViewController = destinationViewController as! OpponentsViewController
                destinationViewController.dataSource = RecentOpponentsDataSource()
                break
            case "segue.opponents.friends":
                break
            case "segue.opponents.nearby":
                break
            default:
                break
            }
        }
    }
    
    @IBAction func unwindToOpponentTypePicker(sender: UIStoryboardSegue) {
        
    }
    
}

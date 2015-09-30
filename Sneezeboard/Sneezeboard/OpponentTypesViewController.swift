//
//  OpponentTypesViewController.swift
//  Sneezeboard
//
//  Created by Cedric Han on 9/29/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class OpponentTypesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
}

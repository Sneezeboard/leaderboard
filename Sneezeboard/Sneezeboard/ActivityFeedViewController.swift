//
//  ActivityFeedViewController.swift
//  Sneezeboard
//
//  Created by Eli Tucker on 9/28/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class ActivityFeedViewController: UITableViewController {

    var matches: [Match] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
            
        setupRefreshControl()
        loadMatches()
    }
    
    func loadMatches() {
        ParseClient.sharedInstance.allMatches { (matches, error) -> () in
            self.matches = matches
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    func addCompletedMatch(match: Match) {
        print("Adding completed match")
        let newMatches = [match] + matches
        matches = newMatches
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell") as! ActivityCell

        cell.match = matches[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    // Hack to use Apple's standard UIRefreshControl in a UIViewController instead of a UITableViewController.
    // See https://guides.codepath.com/ios/Table-View-Guide#implementing-pull-to-refresh-with-uirefreshcontrol
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: "loadMatches", forControlEvents: UIControlEvents.ValueChanged)
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

//
//  ActivityFeedViewController.swift
//  Thunderdome
//
//  Created by Eli Tucker on 9/28/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class ActivityFeedViewController: UITableViewController {

    var matches: [Match] = []
    
    // If a match was just added, this flag is used to animate it in.
    var completedMatchJustAdded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 82
        tableView.separatorStyle = .None
            
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
        completedMatchJustAdded = true
      
        matches.insert(match, atIndex: 0)
        self.tableView.setContentOffset(CGPointMake(0, -tableView.contentInset.top), animated: false)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      NSLog("row \(indexPath.row) section \(indexPath.section)")
      
      let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as! ActivityCell
      
        cell.match = matches[indexPath.section]

        if (indexPath.section == 0 && completedMatchJustAdded) {
            cell.hideLightning()
            cell.contentView.alpha = 0
            cell.contentView.transform = CGAffineTransformMakeScale(4, 4)
            UIView.animateWithDuration(0.4, delay: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                cell.contentView.alpha = 1
                cell.contentView.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: { (Bool) -> Void in
                self.completedMatchJustAdded = false
                cell.showLightning()
            })
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return matches.count
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 15
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let v = UIView()
      v.backgroundColor = UIColor.clearColor()
      return v
    }
  
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: "loadMatches", forControlEvents: UIControlEvents.ValueChanged)
    }
}

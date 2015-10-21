//
//  SportsPickerViewController.swift
//  Sneezeboard
//
//  Created by Cedric Han on 9/29/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse

class SportsPickerViewController: UITableViewController {
    
    var match: Match!
    var sports: [Sport]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        fetchSports()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fetchSports() {
        let query = PFQuery(className:"Sport")
        query.findObjectsInBackgroundWithBlock { (sports, error) -> Void in
            if error != nil {
                // TODO ERRRARR
            } else {
                self.sports = sports as? [Sport]
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell.sport", forIndexPath: indexPath)

        let sport = sports?[indexPath.row]
        cell.textLabel?.text = sport?.name

        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segue.league" {
            let vc = segue.destinationViewController as! LeaguePickerTableViewController
            if let cell = (sender as? UITableViewCell), let indexPath = tableView.indexPathForCell(cell) {
                let sport = self.sports?[indexPath.row]
                let match = Match()
                match.sport = sport
                match.user1 = self.match.user1
                match.user2 = self.match.user2
                vc.match = match
            }
        }
    }

}

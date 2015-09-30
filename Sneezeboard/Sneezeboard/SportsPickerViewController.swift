//
//  SportsPickerViewController.swift
//  Sneezeboard
//
//  Created by Cedric Han on 9/29/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class SportsPickerViewController: UITableViewController {
    
    var match: Match!
    let sports: [(String, String)] = [
        ("icon-chess.png", "Chess"),
        ("icon-table-tennis.png", "Table Tennis"),
        ("icon-tennis.png", "Tennis"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sports.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell.sport", forIndexPath: indexPath)

        let (_, sportName) = sports[indexPath.row]
        cell.textLabel?.text = sportName

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segue.record_result" {
            if let cell = (sender as? UITableViewCell) {
                let indexPath = tableView.indexPathForCell(cell)
                let (_, sportName) = sports[indexPath!.row]
                // match.sport = Sport
                // viewController.match = match
            }
        }
    }

}

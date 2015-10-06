//
//  OpponentsViewController.swift
//  Sneezeboard
//
//  Created by Cedric Han on 9/29/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class OpponentsViewController: UITableViewController {
    
    var dataSource: protocol<UITableViewDataSource, OpponentsDataSource>? {
        didSet {
            if let tableView = tableView {
                tableView.dataSource = dataSource
                tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
        dataSource?.fetch({ (objects, error) -> Void in
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // These methods are here just as a fallback. `dataSource` will provide real numbers
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource?.numberOfSectionsInTableView?(tableView) ?? 0
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segue.sports" {
            let vc = segue.destinationViewController as! SportsPickerViewController
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                let match = Match()
                match.user1 = User.currentUser()
                match.user2 = dataSource?.opponentForIndexPath(indexPath)
                vc.match = match
            }
        }
    }

}

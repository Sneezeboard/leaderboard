//
//  RecentOpponentsDataSource.swift
//  Sneezeboard
//
//  Created by Cedric Han on 9/29/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse


class RecentOpponentsDataSource: NSObject, UITableViewDataSource {
    
    var opponents: [User]?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell.opponent", forIndexPath: indexPath)
        // cell.player = opponents[indexPath.row]
        return cell
    }
    
    func fetch() { // Probably want a completion block or something here
    }
    
}

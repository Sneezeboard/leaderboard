//
//  RecentOpponentsDataSource.swift
//  Sneezeboard
//
//  Created by Cedric Han on 9/29/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse


class RecentOpponentsDataSource: NSObject, UITableViewDataSource, OpponentsDataSource {
    
    var opponents: [User]?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opponents?.count ?? 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return opponents == nil ? 0 : 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell.opponent", forIndexPath: indexPath)
        let opponent = opponents?[indexPath.row]
        cell.textLabel?.text = opponent?.username
        return cell
    }
    
    // MARK: - OpponentsDataSource
    
    func opponentForIndexPath(indexPath: NSIndexPath) -> User? {
        let count = opponents?.count ?? 0
        guard 0 <= indexPath.row && indexPath.row < count else {
            return nil
        }
        
        return opponents?[indexPath.row]
    }
    
    func fetch(completion: (users: [User]?, error: NSError?) -> Void) {
        let query = User.query()
        query!.findObjectsInBackgroundWithBlock { (users, error) -> Void in
            if error != nil {
                completion(users: nil, error: error)
            } else {
                self.opponents = users as? [User]
                completion(users: self.opponents, error: nil)
            }
        }
    }
    
}

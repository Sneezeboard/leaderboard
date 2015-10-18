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
    var allOpponents: [User]?
    var recentOpponents: [User]?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return recentOpponents?.count ?? 0
        } else {
            return allOpponents?.count ?? 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return allOpponents == nil ? 0 : 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Recent"
        } else {
            return "All Players"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell.opponent", forIndexPath: indexPath)
        let opponentList: [User]?
        if (indexPath.section == 0) {
            opponentList = recentOpponents
        } else {
            opponentList = allOpponents
        }
        let opponent = opponentList?[indexPath.row]
        cell.textLabel?.text = opponent?.username
        return cell
    }
    
    // MARK: - OpponentsDataSource
    
    func opponentForIndexPath(indexPath: NSIndexPath) -> User? {
        let count = allOpponents?.count ?? 0
        guard 0 <= indexPath.row && indexPath.row < count else {
            return nil
        }
        
        return allOpponents?[indexPath.row]
    }
    
    func fetch(completion: (users: [User]?, error: NSError?) -> Void) {

        func recentUserQuery(userFieldName: String) -> PFQuery {
            let query = Match.query()
            query!.whereKey(userFieldName, equalTo: User.currentUser()!)
            return query!
        }        
        
        let allUsersQuery = User.query()
        allUsersQuery?.orderByAscending("username")
        allUsersQuery!.findObjectsInBackgroundWithBlock { (users, error) -> Void in
            if error != nil {
                completion(users: nil, error: error)
            } else {
                self.allOpponents = users as? [User]
                
                let recentMatchesWithCurrentUserQuery = PFQuery.orQueryWithSubqueries([recentUserQuery("user1"), recentUserQuery("user2")])
                recentMatchesWithCurrentUserQuery.orderByDescending("createdAt")
                recentMatchesWithCurrentUserQuery.limit = 5
                recentMatchesWithCurrentUserQuery.includeKey("user1")
                recentMatchesWithCurrentUserQuery.includeKey("user2")
                
                recentMatchesWithCurrentUserQuery.findObjectsInBackgroundWithBlock { (matches, error) -> Void in
                
                    if error != nil {
                        completion(users: nil, error: error)
                    } else {
                        
                        // Pick out recent users from matches
                        self.recentOpponents = []
                        if let matches = matches {                                                    
                            for match in matches {
                                let myMatch = match as! Match
                                print("myMatch.user1 == \(myMatch.user1)")
                                print("currentUser == \(User.currentUser())")
                                if (myMatch.user1?.objectId == User.currentUser()?.objectId) {
                                    if let user = myMatch.user2 {
                                        self.recentOpponents!.append(user)
                                    }
                                } else {
                                    if let user = myMatch.user1 {
                                        self.recentOpponents!.append(user)
                                    }
                                }
                            }
                        }
                        
                        // TODO: Remove duplicates.
                        
                        completion(users: self.allOpponents, error: nil)
                    }
                }
            }
        }
    }
    
}

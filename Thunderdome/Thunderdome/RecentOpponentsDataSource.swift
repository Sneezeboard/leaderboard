//
//  RecentOpponentsDataSource.swift
//  Thunderdome
//
//  Created by Cedric Han on 9/29/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse

class RecentOpponentsDataSource: NSObject, UITableViewDataSource, OpponentsDataSource {
    var allOpponents: [User]?
    var recentOpponents: [User]?
  
    var allOpponentsFiltered: [User]?
    var recentOpponentsFiltered: [User]?
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hasRecent() && section == 0 {
            if let opponents = recentOpponentsFiltered {
                return opponents.count
            }
            return recentOpponents?.count ?? 0
        } else {
            if let opponents = allOpponentsFiltered {
                return opponents.count
            }
            return allOpponents?.count ?? 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if allOpponents == nil {
            return 0
        }
        if let recent = recentOpponents {
            if recent.count > 0 {
                return 2
            }
        }

        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if recentOpponents != nil && recentOpponents!.count > 0 && section == 0 {
            return "Recent"
        } else {
            return "All Players"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell.opponent", forIndexPath: indexPath)
        let opponentList: [User]?
        if hasRecent() && indexPath.section == 0 {
            opponentList = recentOpponentsFiltered ?? recentOpponents
        } else {
            opponentList = allOpponentsFiltered ?? allOpponents
        }
        let opponent = opponentList?[indexPath.row]
        cell.textLabel?.text = opponent?.username
        return cell
    }
    
    // MARK: - OpponentsDataSource
  
    func filter(search: String?) {
        if let search = search {
            if let opponents = allOpponents {
                allOpponentsFiltered = doFilter(search, data: opponents)
            }
            if let opponents = recentOpponents {
                recentOpponentsFiltered = doFilter(search, data: opponents)
            }
        } else {
            allOpponentsFiltered = nil
            recentOpponentsFiltered = nil
        }
    }
  
    private func doFilter(search: String, data: [User]) -> [User] {
        return data.filter({ (user) -> Bool in
          let result = (user.username ?? "").lowercaseString.rangeOfString(search.lowercaseString) != nil
          NSLog("checking \(user.username!) against \(search) got \(result)")
          return result
        })
    }
  
    private func hasRecent() -> Bool {
        return recentOpponents != nil && recentOpponents!.count > 0
    }
  
    func opponentForIndexPath(indexPath: NSIndexPath) -> User? {
        let count = allOpponents?.count ?? 0
        guard 0 <= indexPath.row && indexPath.row < count else {
            return nil
        }
        
        if hasRecent() && indexPath.section == 0 {
            return (recentOpponentsFiltered ?? recentOpponents)?[indexPath.row]
        } else {
            return (allOpponentsFiltered ?? allOpponents)?[indexPath.row]
        }
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

//
//  ParseClient.swift
//  Thunderdome
//
//  Created by Eli Tucker on 9/30/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import Parse

class ParseClient {
    class var sharedInstance: ParseClient {
        struct Static {
            static let instance = ParseClient()
        }
        
        return Static.instance
    }
    
    func allMatches(completion: (matches: [Match], error: NSError?) -> ()) -> () {
        let query = PFQuery(className: Match.parseClassName())
        query.orderByDescending("updatedAt")
        query.includeKey("user1")
        query.includeKey("user2")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                print("Successfully retrieved \(objects!.count) matches")
                completion(matches: (objects as! [Match]), error: error)
            } else {
                print("Error getting matches: \(error)")
                completion(matches: [], error: error)
            }
        }
    }
    
    func allSports(completion: (sports: [Sport], error: NSError?) -> ()) -> () {
        let query = PFQuery(className: Sport.parseClassName())
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                print("Successfully retrieved \(objects!.count) sports")
                completion(sports: (objects as! [Sport]), error: error)
            } else {
                print("Error getting sports: \(error)")
                completion(sports: [], error: error)
            }
        }
    }
    
    func allLeagues(completion: (leagues: [League], error: NSError?) -> ()) -> () {
        let query = PFQuery(className: League.parseClassName())
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                print("Successfully retrieved \(objects!.count) leagues")
                completion(leagues: (objects as! [League]), error: error)
            } else {
                print("Error getting leagues: \(error)")
                completion(leagues: [], error: error)
            }
        }
    }
    
    func allUsersByLeague(league: League, completion: (users: [User], error: NSError?) -> ()) -> () {
        // for global league, just grab all users
        if (league.name == League.globalLeagueName()) {
            let query = PFQuery(className: User.parseClassName())
            query.orderByDescending("elo")
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    print("Successfully retrieved \(objects!.count) users")
                    completion(users: (objects as! [User]), error: error)
                } else {
                    print("Error getting league users: \(error)")
                    completion(users: [], error: error)
                }
            }
        } else {
            let query = PFQuery(className: Match.parseClassName())
            query.includeKey("user1")
            query.includeKey("user2")
            query.whereKey("league", equalTo: league)
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    var users: [User] = []
                    var seen = [String: User]()
                    for object in objects! {
                        let match = object as! Match
                        seen[match.user1!.objectId!] = match.user1!
                        seen[match.user2!.objectId!] = match.user2!
                    }
                    
                    for (objectId, user) in seen {
                        users.append(user)
                    }
                    
                    // sort desc by elo
                    users.sortInPlace({ (user1: User, user2: User) -> Bool in
                        return user1.elo > user2.elo
                    })
                    
                    completion(users: users, error: error)
                } else {
                    completion(users: [], error: error)
                }
            }
        }
    }
    
    func allMatchesByLeague(league: League, completion: (matches: [Match], error: NSError?) -> ()) -> () {
        let query = PFQuery(className: Match.parseClassName())
        query.whereKey("league", equalTo: league)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) matches")
                completion(matches: (objects as! [Match]), error: error)
            } else {
                print("Error getting league matches: \(error)")
                completion(matches: [], error: error)
            }
        }
    }

}

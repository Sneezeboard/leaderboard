//
//  ParseClient.swift
//  Sneezeboard
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
    }

}

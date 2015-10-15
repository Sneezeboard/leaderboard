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
        print("I'm here, peeps!")
        let query = PFQuery(className: Match.parseClassName())
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) matches")
                // Do something with the found objects
                completion(matches: (objects as! [Match]), error: error)
            } else {
                // Log details of the failure
                print("Error getting matches: \(error)")
                completion(matches: [], error: error)
            }
        }
    }
    
    func allSports(completion: (sports: [Sport], error: NSError?) -> ()) -> () {
        let query = PFQuery(className: Sport.parseClassName())
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) sports")
                // Do something with the found objects
                completion(sports: (objects as! [Sport]), error: error)
            } else {
                // Log details of the failure
                print("Error getting sports: \(error)")
                completion(sports: [], error: error)
            }
        }
    }
    
    func allLeagues(completion: (leagues: [League], error: NSError?) -> ()) -> () {
        let query = PFQuery(className: League.parseClassName())
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) leagues")
                // Do something with the found objects
                completion(leagues: (objects as! [League]), error: error)
            } else {
                // Log details of the failure
                print("Error getting leagues: \(error)")
                completion(leagues: [], error: error)
            }
        }
    }
    
    func allUsersByLeague(league: League, completetion: (users: [User], error: NSError?) -> ()) -> () {
        //let query =
    }

}

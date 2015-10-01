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
        let query = PFQuery(className:"Match")
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
}
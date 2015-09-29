//
//  Match.swift
//  Sneezeboard
//
//  Created by Eli Tucker on 9/28/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import Parse

@objc class Match : PFObject, PFSubclassing {
    
    @NSManaged var user1: User?
    @NSManaged var user2: User?
    @NSManaged var score1: Int
    @NSManaged var score2: Int
    @NSManaged var date: NSDate
    
    class func parseClassName() -> String { return "Match" }
    
    // Create some dummy data. I'll delete this later.
    class func createSomeMatches() throws {
        let query = PFUser.query()
        let users = try query?.findObjects()
        print("found users: \(users)")

        let aMatch = Match()
        aMatch.user1 = users?[0] as! User?
        aMatch.user2 = users?[1] as! User?
        aMatch.score1 = 11
        aMatch.score2 = 5
        aMatch.date = NSDate()
            
        aMatch.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("It saved!")
            } else {
                print("it broke!")
                print(error)
            }
        }
    }
}
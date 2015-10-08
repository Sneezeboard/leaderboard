//
//  League.swift
//  Sneezeboard
//
//  Created by Will Dalton on 9/30/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import Parse

@objc class League: PFObject, PFSubclassing {
    @NSManaged var name: String?
    @NSManaged var createdBy: User?
    @NSManaged var sport: Sport?
    @NSManaged var location: PFGeoPoint?
    @NSManaged var image: PFFile?
    
    class func parseClassName() -> String {
        return "League"
    }
}

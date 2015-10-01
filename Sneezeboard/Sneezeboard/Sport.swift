//
//  Sport.swift
//  Sneezeboard
//
//  Created by Will Dalton on 9/30/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import Parse

class Sport: PFObject, PFSubclassing {

    @NSManaged var name: String!

    class func parseClassName() -> String { return "Sport" }
    
}

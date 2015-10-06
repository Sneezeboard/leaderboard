//
//  League.swift
//  Sneezeboard
//
//  Created by Will Dalton on 9/30/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import Parse

class League: PFObject {
    var name: String!
    var createdBy: User!
    var sport: Sport!
    var location: PFGeoPoint!
    var image: PFFile!
}

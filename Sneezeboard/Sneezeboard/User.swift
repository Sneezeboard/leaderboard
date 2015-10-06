//
//  User.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import Parse

class User: PFUser {
  @NSManaged var avatar: PFFile?
}
//
//  User.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import Parse

@objc class User: PFObject, PFSubclassing {
  static var currentUser: User! = nil
  
  class func parseClassName() -> String { return "User" }
}
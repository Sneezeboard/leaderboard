//
//  Leaderboard.swift
//  Thunderdome
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import Parse

@objc class Leaderboard: PFObject, PFSubclassing {
  let name: String
  let id: Int
  
  class func parseClassName() -> String { return "Leaderboard" }
  
  override init() {
    name = "Unknown"
    id = 0
    
    super.init()
  }
}

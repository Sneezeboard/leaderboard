//
//  LeaguePickerController.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 9/25/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

protocol LeaguePickerProtocol {
  func donePickingLeagues()
}

class LeaguePickerController: UITableViewController {
  var owner: LeaguePickerProtocol?
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return ["Friends' Leagues", "Nearby Leagues"][section]
  }
  
  @IBAction func doneTouched(sender: AnyObject) {
    if let owner = owner {
      owner.donePickingLeagues()
    }
  }
}

//
//  OpponentsDataSource.swift
//  Sneezeboard
//
//  Created by Cedric Han on 9/30/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse

protocol OpponentsDataSource {
    
    func opponentForIndexPath(indexPath: NSIndexPath) -> User?
    func fetch(completion: (users: [User]?, error: NSError?) -> Void)
    func filter(search: String?)
}

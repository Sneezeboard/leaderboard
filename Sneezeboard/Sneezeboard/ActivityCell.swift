//
//  ActivityCell.swift
//  Sneezeboard
//
//  Created by Eli Tucker on 9/28/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    @IBOutlet weak var user1NameLabel: UILabel!
    @IBOutlet weak var user1ScoreLabel: UILabel!
    @IBOutlet weak var user1ImageView: UIImageView!
    
    @IBOutlet weak var user2NameLabel: UILabel!
    @IBOutlet weak var user2ScoreLabel: UILabel!
    @IBOutlet weak var user2ImageView: UIImageView!
    
    
    var match: Match! {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
    }
}

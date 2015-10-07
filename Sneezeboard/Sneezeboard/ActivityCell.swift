//
//  ActivityCell.swift
//  Sneezeboard
//
//  Created by Eli Tucker on 9/28/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ActivityCell: UITableViewCell {
    
    @IBOutlet weak var user1NameLabel: UILabel!
    @IBOutlet weak var user1ScoreLabel: UILabel!
    @IBOutlet weak var user1ImageView: PFImageView!
    
    @IBOutlet weak var user2NameLabel: UILabel!
    @IBOutlet weak var user2ScoreLabel: UILabel!
    @IBOutlet weak var user2ImageView: PFImageView!
    
    
    var match: Match! {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if match != nil {
            user1ScoreLabel.text = String(match.score1)
            user2ScoreLabel.text = String(match.score2)
            
            match.user1?.fetchIfNeededInBackgroundWithBlock({ (obj: PFObject?, error: NSError?) -> Void in
                let user = obj as! User
                self.user1NameLabel.text = user.username
                self.user1ImageView.file = user.avatar
                self.user1ImageView.loadInBackground()
            })

            match.user2?.fetchIfNeededInBackgroundWithBlock({ (obj: PFObject?, error: NSError?) -> Void in
                let user = obj as! User
                self.user2NameLabel.text = user.username
                self.user2ImageView.file = user.avatar
                self.user2ImageView.loadInBackground()
            })

            // TODO: Set the profile images.
//            user1ImageView.setImageWithURL(<#T##url: NSURL##NSURL#>)
        }
    }
}

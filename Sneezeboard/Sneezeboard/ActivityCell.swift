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
import DateTools

class ActivityCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var user1NameLabel: UILabel!
    @IBOutlet weak var user1ImageView: PFImageView!
    @IBOutlet weak var user2NameLabel: UILabel!
    @IBOutlet weak var user2ImageView: PFImageView!
    
    
    var match: Match! {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if match != nil {

            polishImage(user1ImageView)
            polishImage(user2ImageView)
          
            let ago = match.createdAt?.shortTimeAgoSinceNow() ?? "recently"
            timeLabel.text = "\(ago) ago"
            
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
  
    private func polishImage(view: UIImageView) {
        view.layer.borderWidth = 2
        view.layer.masksToBounds = false
        view.layer.cornerRadius = view.frame.size.width / 2
        view.layer.borderColor = UIColor.blackColor().CGColor //UIColor(red: 255 / 255.0, green: 94 / 255.0, blue: 85 / 255.0, alpha: 1).CGColor
        view.clipsToBounds = true
    }
}

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
    @IBOutlet weak var user1Lightning: UIImageView!
    @IBOutlet weak var user2Lightning: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var user1NameLabel: UILabel!
    @IBOutlet weak var user1ImageView: PFImageView!
    @IBOutlet weak var user2NameLabel: UILabel!
    @IBOutlet weak var user2ImageView: PFImageView!
    @IBOutlet weak var view: UIView!
    var activeLightning: UIImageView?
  
    var match: Match! {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if match != nil {

            polishImage(user1ImageView)
            polishImage(user2ImageView)
          
            user1Lightning.layer.cornerRadius = user1Lightning.frame.size.width / 2
            user2Lightning.layer.cornerRadius = user1Lightning.layer.cornerRadius
            user1Lightning.clipsToBounds = true
            user2Lightning.clipsToBounds = true
          
            setupWinner()
          
            let ago = match.createdAt?.shortTimeAgoSinceNow() ?? "recently"
            timeLabel.text = "\(ago) ago"
            
            match.user1?.fetchIfNeededInBackgroundWithBlock({ (obj: PFObject?, error: NSError?) -> Void in
                let user = obj as! User
                self.user1NameLabel.text = user.username
                if (user.avatar != nil) {
                    self.user1ImageView.file = user.avatar
                    self.user1ImageView.loadInBackground()
                } else {
                    self.user1ImageView.image = UIImage(named: "default-avatar")
                }
            })

            match.user2?.fetchIfNeededInBackgroundWithBlock({ (obj: PFObject?, error: NSError?) -> Void in
                let user = obj as! User
                self.user2NameLabel.text = user.username
                
                if (user.avatar != nil) {
                    self.user2ImageView.file = user.avatar
                    self.user2ImageView.loadInBackground()
                } else {
                    self.user2ImageView.image = UIImage(named: "default-avatar")
                }

            })
        }
    }

    func hideLightning() {
        activeLightning?.transform = CGAffineTransformMakeTranslation(0, 20)
        activeLightning?.alpha = 0
    }
  
    func showLightning() {
        UIView.animateWithDuration(0.2) { () -> Void in
            self.activeLightning?.alpha = 1
            self.activeLightning?.transform = CGAffineTransformIdentity
        }
    }
  
    private func polishImage(view: UIImageView) {
        view.layer.borderWidth = 2
        view.layer.masksToBounds = false
        view.layer.cornerRadius = view.frame.size.width / 2
        view.layer.borderColor = UIColor.blackColor().CGColor //UIColor(red: 255 / 255.0, green: 94 / 255.0, blue: 85 / 255.0, alpha: 1).CGColor
        view.clipsToBounds = true
    }
  
    private func setupWinner() {
        if match.score1 > match.score2 {
            user1Lightning.hidden = false
            user2Lightning.hidden = true
            activeLightning = user1Lightning
        } else if match.score2 > match.score1 {
            user1Lightning.hidden = true
            user2Lightning.hidden = false
            activeLightning = user2Lightning
        }
    }
}

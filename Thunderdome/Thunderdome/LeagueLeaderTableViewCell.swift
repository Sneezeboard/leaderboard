//
//  LeagueLeaderTableViewCell.swift
//  Thunderdome
//
//  Created by Will Dalton on 10/14/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LeagueLeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    @IBOutlet weak var userImageView: PFImageView!
    @IBOutlet weak var leaderTrophyLabel: UILabel!
    
    var user: User! {
        didSet {
            updateView()
        }
    }
    
    var leagueLeader: Bool?
    
    func updateView() {
        nameLabel.text = user.username
        eloLabel.text = "\(user!.elo)"
        polishImage(userImageView)
        if (user.avatar != nil) {
            self.userImageView.file = user.avatar
            self.userImageView.loadInBackground()
        } else {
            self.userImageView.image = UIImage(named: "default-avatar")
        }
        
        // give league leader a trophy
        if let leagueLeader = leagueLeader {
            leaderTrophyLabel.hidden = !leagueLeader
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func polishImage(view: UIImageView) {
        view.layer.borderWidth = 2
        view.layer.masksToBounds = false
        view.layer.cornerRadius = view.frame.size.width / 2
        view.layer.borderColor = UIColor.blackColor().CGColor //UIColor(red: 255 / 255.0, green: 94 / 255.0, blue: 85 / 255.0, alpha: 1).CGColor
        view.clipsToBounds = true
    }
    
}

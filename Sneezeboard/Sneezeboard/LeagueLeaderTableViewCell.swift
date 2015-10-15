//
//  LeagueLeaderTableViewCell.swift
//  Sneezeboard
//
//  Created by Will Dalton on 10/14/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class LeagueLeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var eloLabel: UILabel!
    
    var user: User! {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        nameLabel.text = user.username
        eloLabel.text = "\(user!.elo)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

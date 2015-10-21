//
//  LeagueTableViewCell.swift
//  Thunderdome
//
//  Created by Will Dalton on 10/7/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueImageView: PFImageView!
    
    var league: League! {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        leagueNameLabel.text = league.name
        if (league.image == nil && league.name == League.globalLeagueName()) {
            // special handling for the fake global league
        } else if (league.image != nil) {
            self.leagueImageView.file = league.image
            self.leagueImageView.loadInBackground()
        } else {
            // add some default league image when we support more leagues (we will all
            // be very wealthy at that point)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

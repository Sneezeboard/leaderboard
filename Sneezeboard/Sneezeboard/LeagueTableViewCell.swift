//
//  LeagueTableViewCell.swift
//  Sneezeboard
//
//  Created by Will Dalton on 10/7/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueNameLabel: UILabel!

    var league: League! {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        leagueNameLabel.text = league.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

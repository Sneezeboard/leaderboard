//
//  UserView.swift
//  Sneezeboard
//
//  Created by Patrick Stein on 10/20/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit
import AFNetworking

@IBDesignable
class UserView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var avatarImage: UIImageView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initSubviews()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initSubviews()
  }
  
  var user: User! {
    didSet {
      usernameLabel.text = user.username
      
      if let urlStr = user.avatar?.url, url = NSURL(string: urlStr) {
        avatarImage.alpha = 0
        let req = NSURLRequest(URL: url)
        avatarImage.setImageWithURLRequest(req, placeholderImage: nil, success: { (_, _, img) -> Void in
          UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.avatarImage.image = img
            self.avatarImage.alpha = 1
          })
        }, failure: nil)
      }
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    layer.borderWidth = layer.frame.width / 100
    layer.borderColor = UIColor.blackColor().CGColor
    layer.cornerRadius = layer.frame.width / 2
    clipsToBounds = true
  }
  
  private func initSubviews() {
    let nib = UINib(nibName: "UserView", bundle: nil)
    nib.instantiateWithOwner(self, options: nil)
    contentView.frame = bounds
    addSubview(contentView)
  }
}

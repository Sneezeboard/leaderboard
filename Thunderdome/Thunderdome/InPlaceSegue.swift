//
//  InPlaceSegue.swift
//  Thunderdome
//
//  Created by Patrick Stein on 10/13/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class InPlaceSegue: UIStoryboardSegue {
  var unwind = false
  
  override func perform() {
    if let dest = destinationViewController as? AuthController, let source = sourceViewController as? AuthController {
      source.slideOut({ () -> Void in
        if !self.unwind {
          source.presentViewController(dest, animated: false, completion: { () -> Void in
            dest.slideIn(nil)
          })
        } else {
          source.dismissViewControllerAnimated(false, completion: { () -> Void in
            dest.slideIn(nil)
          })
        }
      })
    }
  }
}

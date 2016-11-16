//
//  MultilineButton.swift
//  GraphTest
//
//  Created by Neetin Sharma on 11/15/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit

class MultilineButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

  
  override func layoutSubviews() {
    self.titleLabel!.lineBreakMode = .byWordWrapping
    self.titleLabel!.textAlignment = .center
  }
  
}

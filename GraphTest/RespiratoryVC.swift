//
//  RespiratoryVC.swift
//  GraphTest
//
//  Created by Neetin Sharma on 11/14/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit

class RespiratoryVC: UIViewController {

  @IBOutlet weak var segmentControl: UISegmentedControl!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSegmentUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  func configureSegmentUI() {
    
//    segmentControl.frame = CGRect(x: 0, y: 0, width: 800, height: 200)
    
    for segment in segmentControl.subviews {
      for label in segment.subviews {
        if label.isKind(of: UILabel.self) {
          let l = label as! UILabel
          l.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
          l.numberOfLines = 0
        }
      }
    }
    
  }
  
  
}

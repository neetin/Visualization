//
//  CheckVC.swift
//  GraphTest
//
//  Created by Neetin Sharma on 11/16/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit

class CheckVC: UIViewController {

  @IBOutlet weak var dayNIght: DayNightView!
  
  @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

      dayNIght.isDaySelected = false
      dayNIght.delegate = self
      
      
      addDayNightViews()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  func addDayNightViews() {
    var x = 8
    let width = 150
    for i: Int in 0 ..< 10 {
      let view = DayNightView(frame: CGRect(x: x, y: 8, width: width, height: 96))
      x += width + 8
      view.delegate = self
      view.isDaySelected = (i%2) == 0 ? true: false
      view.shiftDate = Date()
      scrollView.addSubview(view)
    }
    
    scrollView.contentSize = CGSize(width: x + 16, height: 104)
    scrollView.isScrollEnabled = true
  }
}

extension CheckVC: DayNightDelegate {
  func dayButtonPressed() {
    print("day button pressed")
  }
  
  func nightButtonPressed() {
    print("night button pressed")
  }
}

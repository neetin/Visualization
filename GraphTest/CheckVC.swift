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
  
    override func viewDidLoad() {
        super.viewDidLoad()

      dayNIght.isDaySelected = false
      dayNIght.delegate = self
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CheckVC: DayNightDelegate {
  func dayButtonPressed() {
    print("day button pressed")
  }
  
  func nightButtonPressed() {
    print("night button pressed")
  }
}

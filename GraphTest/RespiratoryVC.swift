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
  
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSegmentUI()
        setupInitialView()
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
    segmentControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
    
  }
    func setupInitialView() {
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OxygenSaturationSegmentVC")
        containerView.addSubview(vc.view)
    }
    
    func selectionDidChange(_ sender: UISegmentedControl) {
        configureView()
    }
    
    func configureView() {
        if segmentControl.selectedSegmentIndex == 2 {
            configureVC(withName: "DesatVC")
        } else {
            configureVC(withName: "OxygenSaturationSegmentVC")
        }
    }
    
    func configureVC(withName: String) {
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: withName)
        containerView.addSubview(vc.view)
        
    }
  
}

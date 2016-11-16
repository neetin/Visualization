//
//  DayNightView.swift
//  GraphTest
//
//  Created by Neetin Sharma on 11/16/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit


protocol DayNightDelegate {
  func dayButtonPressed()
  func nightButtonPressed()
}

@IBDesignable class DayNightView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  
  
  var view: UIView!
  var delegate: DayNightDelegate?
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var nightButton: UIButton!
  @IBOutlet weak var dayButton: UIButton!
  
  
  @IBInspectable var isDaySelected: Bool = true {
    didSet {
      if isDaySelected {
        dayButton.backgroundColor = ThemeColor.primaryTint
        dayButton.setTitleColor(UIColor.white, for: .normal)
        
        nightButton.backgroundColor = UIColor.white
        nightButton.setTitleColor(ThemeColor.primaryTint, for: .normal)
      } else {
        dayButton.backgroundColor = UIColor.white
        dayButton.setTitleColor(ThemeColor.primaryTint, for: .normal)
        
        nightButton.backgroundColor = ThemeColor.primaryTint
        nightButton.setTitleColor(UIColor.white, for: .normal)
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }
  
  
  func xibSetup() {
    view = loadViewFromNib()
    
    // use bounds not frame or it'll be offset
    view.frame = bounds
    
    // Make the view stretch with containing view
    view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    // Adding custom subview on top of our view (over any custom drawing > see note below)
    addSubview(view)
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "DayNightView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    view.layer.cornerRadius = 10
    view.layer.borderWidth = 2
    view.layer.borderColor = ThemeColor.primaryTint.cgColor
    view.backgroundColor = UIColor.clear
    view.clipsToBounds = true
    return view
  }

  
  @IBAction func dayButtonPressed(_ sender: AnyObject) {
   self.delegate?.dayButtonPressed()
  }
  
  @IBAction func nightButtonPressed(_ sender: AnyObject) {
    self.delegate?.nightButtonPressed()
    
  }
  
}


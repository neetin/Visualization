//
//  CustomTabButton.swift
//  GraphTest
//
//  Created by Neetin Sharma on 11/15/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit

class CustomTabButton: UIButton {

  
  @IBInspectable var borderColor: UIColor = UIColor.white {
    didSet {
      layer.borderColor = borderColor.cgColor
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 2.0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var appearAtFront: Bool = false {
    didSet {
      //
    }
  }
  
  @IBInspectable var roundCorner: CGFloat = 1.0 {
    didSet {
      layer.cornerRadius = roundCorner
    }
  }
  
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    if appearAtFront {
      let view = UIView()
      view.frame = CGRect(x: 0, y: self.frame.height - 10, width: self.frame.width, height: 20)
      view.backgroundColor = UIColor.green
      self.addSubview(view)
      
//      let aLayer = CALayer()
//      aLayer.frame = CGRect(x: 0, y: self.frame.height - 10, width: self.frame.width, height: 10)
//      aLayer.backgroundColor = UIColor.green.cgColor
//      self.layer.addSublayer(aLayer)
      
    }
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
  
    self.titleLabel!.lineBreakMode = .byWordWrapping
    self.titleLabel!.textAlignment = .center
//    self.setTitle("Line1\nLine2", for: .normal)
    
//    let borderLayer = CAShapeLayer()
//    borderLayer.strokeColor = UIColor.black.cgColor
//    borderLayer.fillColor = UIColor.yellow.cgColor
//    borderLayer.contentsScale = UIScreen.main.scale
//    borderLayer.shouldRasterize = true
//    let borderPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width:10, height: 10))
//    
//    //borderPath.miterLimit = -50
//    borderLayer.path = borderPath.cgPath
//    
//    layer.insertSublayer(borderLayer, at: 0)
    
//    clipsToBounds = true
    
    
  }
}

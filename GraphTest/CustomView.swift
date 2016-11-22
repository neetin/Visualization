//
//  CustomView.swift
//  GraphTest
//
//  Created by Sujan Vaidya on 11/22/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        let customGreen = ThemeColor.layeredColor
        customGreen.setFill()
        path.fill()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
}

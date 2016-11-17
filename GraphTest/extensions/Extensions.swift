//
//  Extensions.swift
//  PPN
//
//  Created by Neetin Sharma on 4/7/15.
//  Copyright (c) 2015 Vastika. All rights reserved.
//

import UIKit
public extension String {
  
  func isEmpty() -> Bool {
    let temp = self.trimmingCharacters(in: CharacterSet.whitespaces)
    if temp.characters.count > 0 {
      return false
    }
    return true
  }
  
  func isValidEmail() -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: self) ? true : false
  }
  
  func isValidPhone() -> Bool {
    let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: self)
    return result
    
  }
  
  func isValidNumber() -> Bool {
    let number_Regex = "^\\d+"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", number_Regex)
    let result =  phoneTest.evaluate(with: self)
    return result
  }
  
  func dateFromString(_ format: String)-> Date? {
    let dateFor = DateFormatter()
    dateFor.dateFormat = format
    dateFor.timeZone = TimeZone(identifier: "UTC")
    return dateFor.date(from: self)!
  }
  
  func removeHTMLTags() -> String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }
  
}

public extension Data {
  func toHex() -> String
  {
    var str: String = String()
    let p = (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count)
    let len = self.count
    for i in 0 ..< len {
      str += String(format: "%02.2X", p[i])
    }
    return str
  }
}




public extension UIView {
  
  func setRoundedBorder(color : String, width: CGFloat, radius : CGFloat) {
    self.layer.borderColor = UIColor(hex: color).cgColor
    self.layer.borderWidth = width
    self.layer.cornerRadius = radius
  }
  
  func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}


public extension UIImage {
  
  func resize(_ scale:CGFloat)-> UIImage {
    let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
    imageView.contentMode = UIViewContentMode.scaleAspectFit
    imageView.image = self
    UIGraphicsBeginImageContext(imageView.bounds.size)
    imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
    let result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return result!
  }
  
  func resizeToWidth(_ width:CGFloat)-> UIImage {
    let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
    imageView.contentMode = UIViewContentMode.scaleAspectFit
    imageView.image = self
    UIGraphicsBeginImageContext(imageView.bounds.size)
    imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
    let result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return result!
  }
}

extension Date {
  
  func differenceInDaysWithDate(_ date: Date) -> Int {
    let calendar: Calendar = Calendar.current
    let date1 = calendar.startOfDay(for: self)
    let date2 = calendar.startOfDay(for: date)    
    let components = (calendar as NSCalendar).components(.day, from: date1, to: date2, options: [])
    return components.day!
  }
  
  func isBetweenDates(_ beginDate: Date, endDate: Date) -> Bool {
    if self.compare(beginDate) == .orderedAscending { return false }
    if self.compare(endDate) == .orderedDescending { return false }
    return true
  }
}

extension UIApplication {
  class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
      return topViewController(nav.visibleViewController)
    }
    if let tab = base as? UITabBarController {
      if let selected = tab.selectedViewController {
        return topViewController(selected)
      }
    }
    if let presented = base?.presentedViewController {
      return topViewController(presented)
    }
    return base
  }
}

extension Double {
  /// Rounds the double to decimal places value
  func roundTo(places:Int) -> String {
    let divisor = pow(10.0, Double(places))
    if fmod(fmod((self * divisor).rounded() , divisor), 10) == 0 { //Example 10.90 = 1090%100 = 90%10 == 0
      let string = String((self * divisor).rounded() / divisor)+"0"
      return string
    }
    return String((self * divisor).rounded() / divisor)
  }
}

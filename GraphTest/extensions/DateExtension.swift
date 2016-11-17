//
//  DateExtension.swift
//  BattiAayoFirebase
//
//  Created by Prekshya Basnet on 9/2/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import Foundation

func NSDateTimeAgoLocalizedStrings(_ key: String) -> String {
  let resourcePath: String?
  
  if let frameworkBundle = Bundle(identifier: "com.kevinlawler.NSDateTimeAgo") {
    // Load from Framework
    resourcePath = frameworkBundle.resourcePath
  } else {
    // Load from Main Bundle
    resourcePath = Bundle.main.resourcePath
  }
  
  if resourcePath == nil {
    return ""
  }
  
  let path = URL(fileURLWithPath: resourcePath!).appendingPathComponent("NSDateTimeAgo.bundle")
  guard let bundle = Bundle(url: path) else {
    return ""
  }
  
  return NSLocalizedString(key, tableName: "NSDateTimeAgo", bundle: bundle, comment: "")
}

func getComponent(_ date: Date) -> DateComponents {
  let calendar = Calendar.current
  return (calendar as NSCalendar).components([.day, .month, .year, .second, .hour, .minute], from: date)
}

struct Dateformat {
  static let fromAPI = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
  static let toDisplay = "MMM dd, yyyy, hh:mm a"
  
  static let toDisplayTimeOnly = "hh:mm a"
  static let toDisplayDateOnly = "MMM dd, yyyy"
}

extension Date {
  
  func stringFromDate(_ format: String)-> String {
    let dateFor = DateFormatter()
    dateFor.dateFormat = format
    dateFor.timeZone = TimeZone.current
    return dateFor.string(from: self)
  }
  
  func isSameDay(_ endDate: Date)-> Bool {
    return getComponent(self).day == getComponent(endDate).day ? true : false
  }
  
  func getDuration(_ endDate: Date) -> String {
    let dFormat = "%02d"
    let startDateSecond = getComponent(self).hour! * 3600 + getComponent(self).minute!*60 + getComponent(self).second!
    let endDateSecond = getComponent(endDate).hour! * 3600 + getComponent(endDate).minute!*60 + getComponent(endDate).second!
    let duration = endDateSecond - startDateSecond
    var hours = Int(duration/3600)
    var min = duration % 3600
    if min >= 60 {
      hours = hours + 1
      min = Int(min/60)
    }
    var mins: String = ""
    var time: String = String(hours) + " hours "
    if !(min == 0){
      if !(min == 1){
        mins = String(format: dFormat, min) + " mins "
      } else {
        mins = String(format: dFormat, min) + " min "
      }
      time = time +  "and " + mins
    }
    return time
  }
  
  
  // shows 1 or two letter abbreviation for units.
  // does not include 'ago' text ... just {value}{unit-abbreviation}
  // does not include interim summary options such as 'Just now'
  public var timeAgoSimple: String {
    let components = self.dateComponents()
    
    if let year = components.year {
      if year > 0 {
        return "\(year)"+"y ago"
      }
    }
    
    if let month = components.month {
      if month  > 0 {
        return "\(month)"+"mo ago"
      }
    }
    
    if let day = components.day {
      if day >= 7 {
        let value = day/7
        return "\(value)"+"w ago"
      }
      
      if day > 0 {
        return "\(day)"+"d ago"
      }
    }
    
    
    if let hour = components.hour {
      if hour > 0 {
        return "\(hour)"+"h ago"
      }
    }
    
    
    if let minute = components.minute {
      if minute > 0 {
        return "\(minute)"+"m ago"
      }
    }
    
    if let second = components.second {
      
      if second > 0 {
        return "\(second)"+"s ago"
      }
    }
    
    return ""
  }

  
  fileprivate func dateComponents() -> DateComponents {
    let calendar = NSCalendar.current
    return calendar.dateComponents( [.weekday, .hour, .month, .day, .year, .minute, .second], from: self, to: Date())
  }
  
  fileprivate func stringFromFormat(_ format: String, withValue value: Int) -> String {
    let localeFormat = String(format: format, getLocaleFormatUnderscoresWithValue(Double(value)))
    return String(format: NSDateTimeAgoLocalizedStrings(localeFormat), value)
  }
  
  fileprivate func getLocaleFormatUnderscoresWithValue(_ value: Double) -> String {
    guard let localeCode = NSLocale.preferredLanguages.first else {
      return ""
    }
    
    // Russian (ru) and Ukrainian (uk)
    if localeCode.hasPrefix("ru") || localeCode.hasPrefix("uk") {
      let XY = Int(floor(value)) % 100
      let Y = Int(floor(value)) % 10
      
      if Y == 0 || Y > 4 || (XY > 10 && XY < 15) {
        return ""
      }
      
      if Y > 1 && Y < 5 && (XY < 10 || XY > 20) {
        return "_"
      }
      
      if Y == 1 && XY != 11 {
        return "__"
      }
    }
    
    return ""
  }
  
}

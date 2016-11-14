//
//  DataCollection.swift
//  GraphTest
//
//  Created by Sujan Vaidya on 11/14/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import Foundation

/*
 min- 75
 max- 95
 
 maxThreshold- 92
 minThreshold- 85
 
 Desaturation episodes should be total 30(day and night)
 
 For desaturation calculation:
 | Index | Date  | Shift |
 | 0     | Nov13 | Day   |
 | 1     | Nov13 | Night |
 | 2     | Nov12 | Day   |
 | 3     | Nov12 | Night |
 | 4     | Nov11 | Day   |
 | 5     | Nov11 | Night |
 | 6     | Nov10 | Day   |
 | 7     | Nov10 | Night |
 | 8     | Nov9  | Day   |
 | 9     | Nov9  | Night |
 | 10    | Nov8  | Day   |
 | 11    | Nov8  | Night |
 | 12    | Nov7  | Day   |
 | 13    | Nov7  | Night |
 */

struct DataCollection {
    
    static let max : UInt32 = 95
    static let min : UInt32 = 75
    static var datas: [Double] = []
    static var episodeCreated = false
    static var maxEpisodeAllowed = 0
    static var commonNightDayData: Double = 0
    static var commonDayNightData: Double = 0
    static var appendPosition = ""
    
    static func getOxygenSaturationData(withIndex index: Int) -> [Double] {
        datas = []
        setMaxEpisodeAllowed(withIndex: index)
        
        if index == 13 {
            appendData(maxLimit: 144)
            datas.append(commonDayNightData)
        } else {
            datas.append(commonDayNightData)// beginning
            appendData(maxLimit: 143)
            datas.append(commonNightDayData)// end
        }
        
        return datas
    }
    
    static func appendData(maxLimit: Int) {
        var episodeCount = 0
        for _ in 0..<maxLimit {
            let number = getValidNumber(withEpisodeCount: episodeCount)
            if episodeCreated {
                episodeCount = episodeCount + 1
            }
            datas.append(number)
            
        }
    }
    
    // returns number so that the total desaturation episodes is less than or equal to 30
    static func getValidNumber(withEpisodeCount episodeCount: Int) -> Double {
        var randomNumber = Int(arc4random_uniform(max - min) + min)
        if randomNumber < 85 {
            episodeCreated = true
            if episodeCount >= maxEpisodeAllowed {
                randomNumber = Int(getValidNumber(withEpisodeCount: episodeCount))
            }
        } else {
            episodeCreated = false
        }
        return Double(randomNumber)
    }
    
    static func setMaxEpisodeAllowed(withIndex index: Int) {
        switch index {
        case 0: //day
            commonDayNightData = 88
            maxEpisodeAllowed = 12
            commonNightDayData = 87
            
        case 1: //night
            commonDayNightData = 87
            maxEpisodeAllowed = 18
            commonNightDayData = 88
            
        case 2: //day
            commonDayNightData = 88
            maxEpisodeAllowed = 14
            commonNightDayData = 87
            
        case 3: //night
            commonDayNightData = 86
            maxEpisodeAllowed = 16
            commonNightDayData = 88
            
        case 4: //day
            commonDayNightData = 88
            maxEpisodeAllowed = 13
            commonNightDayData = 86
            
        case 5: //night
            commonDayNightData = 86
            maxEpisodeAllowed = 14
            commonNightDayData = 88
            
        case 6: //day
            commonDayNightData = 86
            maxEpisodeAllowed = 11
            commonNightDayData = 86
            
        case 7: //night
            commonDayNightData = 87
            maxEpisodeAllowed = 17
            commonNightDayData = 86
            
        case 8: //day
            commonDayNightData = 91
            maxEpisodeAllowed = 15
            commonNightDayData = 87
            
        case 9: //night
            commonDayNightData = 88
            maxEpisodeAllowed = 15
            commonNightDayData = 91
            
        case 10: //day
            commonDayNightData = 87
            maxEpisodeAllowed = 20
            commonNightDayData = 88
            
        case 11: //night
            commonDayNightData = 90
            maxEpisodeAllowed = 8
            commonNightDayData = 87
            
        case 12: //day
            commonDayNightData = 86
            maxEpisodeAllowed = 9
            commonNightDayData = 90
            
        case 13: //night
            maxEpisodeAllowed = 10
            commonNightDayData = 86
            
        default:
            break
        }
    }
    
    static func getDesaturationEpisodes() -> [Int] {
        let desaturationData = [12, 18, 14, 16, 13, 14, 11, 17, 15, 15, 20, 8, 9, 10]
        return desaturationData
    }
    
    static func getDayShiftLabels() -> [String] {
        let timeLabel = ["7am", "7.05am", "7.10am", "7.15am", "7.20am", "7.25am", "7.30am", "7.35am", "7.40am", "7.45am", "7.50am", "7.55am",
                                "8am", "7.05am", "8.10am", "8.15am", "8.20am", "8.25am", "8.30am", "8.35am", "8.40am", "8.45am", "8.50am", "8.55am",
                                "9am", "9.05am", "9.10am", "9.15am", "9.20am", "9.25am", "9.30am", "9.35am", "9.40am", "9.45am", "9.50am", "9.55am",
                                "10am", "10.05am", "10.10am", "10.15am", "10.20am", "10.25am", "10.30am", "10.35am", "10.40am", "10.45am", "10.50am", "10.55am",
                                "11am", "11.05am", "11.10am", "11.15am", "11.20am", "11.25am", "11.30am", "11.35am", "11.40am", "11.45am", "11.50am", "11.55am",
                                "12pm", "12.05pm", "12.10pm", "12.15pm", "12.20pm", "12.25pm", "12.30pm", "12.35pm", "12.40pm", "12.45pm", "12.50pm", "12.55pm",
                                "1pm", "1.05pm", "1.10pm", "1.15pm", "1.20pm", "1.25pm", "1.30pm", "1.35pm", "1.40pm", "1.45pm", "1.50pm", "1.55pm",
                                "2pm", "2.05pm", "2.10pm", "2.15pm", "2.20pm", "2.25pm", "2.30pm", "2.35pm", "2.40pm", "2.45pm", "2.50pm", "2.55pm",
                                "3pm", "3.05pm", "3.10pm", "3.15pm", "3.20pm", "3.25pm", "3.30pm", "3.35pm", "3.40pm", "3.45pm", "3.50pm", "3.55pm",
                                "4pm", "4.05pm", "4.10pm", "4.15pm", "4.20pm", "4.25pm", "4.30pm", "4.35pm", "4.40pm", "4.45pm", "4.50pm", "4.55pm",
                                "5pm", "5.05pm", "5.10pm", "5.15pm", "5.20pm", "5.25pm", "5.30pm", "5.35pm", "5.40pm", "5.45pm", "5.50pm", "5.55pm",
                                "6pm", "6.05pm", "6.10pm", "6.15pm", "6.20pm", "6.25pm", "6.30pm", "6.35pm", "6.40pm", "6.45pm", "6.50pm", "6.55pm",
                                "7pm"]
        return timeLabel
    }
    
    static func getNightShiftLabels() -> [String] {
        let timeLabel = ["7pm", "7.05pm", "7.10pm", "7.15pm", "7.20pm", "7.25pm", "7.30pm", "7.35pm", "7.40pm", "7.45pm", "7.50pm", "7.55pm",
                         "8pm", "7.05pm", "8.10pm", "8.15pm", "8.20pm", "8.25pm", "8.30pm", "8.35pm", "8.40pm", "8.45pm", "8.50pm", "8.55pm",
                         "9pm", "9.05pm", "9.10pm", "9.15pm", "9.20pm", "9.25pm", "9.30pm", "9.35pm", "9.40pm", "9.45pm", "9.50pm", "9.55pm",
                         "10pm", "10.05pm", "10.10pm", "10.15pm", "10.20pm", "10.25pm", "10.30pm", "10.35pm", "10.40pm", "10.45pm", "10.50pm", "10.55pm",
                         "11pm", "11.05pm", "11.10pm", "11.15pm", "11.20pm", "11.25pm", "11.30pm", "11.35pm", "11.40pm", "11.45pm", "11.50pm", "11.55pm",
                         "12am", "12.05am", "12.10am", "12.15am", "12.20am", "12.25am", "12.30am", "12.35am", "12.40am", "12.45am", "12.50am", "12.55am",
                         "1am", "1.05am", "1.10am", "1.15am", "1.20am", "1.25am", "1.30am", "1.35am", "1.40am", "1.45am", "1.50am", "1.55am",
                         "2am", "2.05am", "2.10am", "2.15am", "2.20am", "2.25am", "2.30am", "2.35am", "2.40am", "2.45am", "2.50am", "2.55am",
                         "3am", "3.05am", "3.10am", "3.15am", "3.20am", "3.25am", "3.30am", "3.35am", "3.40am", "3.45am", "3.50am", "3.55am",
                         "4am", "4.05am", "4.10am", "4.15am", "4.20am", "4.25am", "4.30am", "4.35am", "4.40am", "4.45am", "4.50am", "4.55am",
                         "5am", "5.05am", "5.10am", "5.15am", "5.20am", "5.25am", "5.30am", "5.35am", "5.40am", "5.45am", "5.50am", "5.55am",
                         "6am", "6.05am", "6.10am", "6.15am", "6.20am", "6.25am", "6.30am", "6.35am", "6.40am", "6.45am", "6.50am", "6.55am",
                         "7am"]
        return timeLabel
    }
}

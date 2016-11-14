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
    static var episodeCreated = false
    static var maxEpisodeAllowed = 0
    
    static func getOxygenSaturationData(withIndex index: Int) -> [Int] {
        
        var datas: [Int] = []
        var episodeCount = 0
        for _ in 0..<156 {
            setMaxEpisodeAllowed(withIndex: index)
            let number = getValidNumber(withEpisodeCount: episodeCount)
            if episodeCreated {
                episodeCount = episodeCount + 1
            }
            datas.append(number)
        }
        return datas
    }
    
    // returns number so that the total desaturation episodes is less than or equal to 30
    static func getValidNumber(withEpisodeCount episodeCount: Int) -> Int {
        var randomNumber = Int(arc4random_uniform(max - min) + min)
        if randomNumber < 85 {
            episodeCreated = true
            if episodeCount >= maxEpisodeAllowed {
                randomNumber = getValidNumber(withEpisodeCount: episodeCount)
            }
        } else {
            episodeCreated = false
        }
        return randomNumber
    }
    
    static func setMaxEpisodeAllowed(withIndex index: Int) {
        switch index {
        case 0:
            maxEpisodeAllowed = 12
            
        case 1:
            maxEpisodeAllowed = 18
            
        case 2:
            maxEpisodeAllowed = 14
            
        case 3:
            maxEpisodeAllowed = 16
            
        case 4:
            maxEpisodeAllowed = 13
            
        case 5:
            maxEpisodeAllowed = 14
            
        case 6:
            maxEpisodeAllowed = 11
            
        case 7:
            maxEpisodeAllowed = 17
            
        case 8:
            maxEpisodeAllowed = 15
            
        case 9:
            maxEpisodeAllowed = 15
            
        case 10:
            maxEpisodeAllowed = 20
            
        case 11:
            maxEpisodeAllowed = 8
            
        case 12:
            maxEpisodeAllowed = 9
            
        case 13:
            maxEpisodeAllowed = 10
            
        default:
            break
        }
    }
    
    static func getDesaturationEpisodes() -> [Int] {
        let desaturationData = [12, 18, 14, 16, 13, 14, 11, 17, 15, 15, 20, 8, 9, 10]
        return desaturationData
    }
}

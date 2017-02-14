//
//  Weather.swift
//  DemoBar
//
//  Created by hocgin on 13/02/2017.
//  Copyright © 2017 hocgin. All rights reserved.
//

import Foundation

struct Weather {
    var city: String
    var currentTemp: Float
    var conditions: String
    var icon:String
    var sunrise:Int
    var sunset:Int
    
    func description()-> String {
        var description = ""
        var showIndex = Custom.getShowIndex()
        if showIndex % 10 == 1 {
            description += " \(city) "
            showIndex-=1
        }
        if showIndex % 100 == 10 {
            description += " \(currentTemp)\(Custom.units[Custom.getUnit()]!) "
            showIndex-=10
        }
        if showIndex % 1000 == 100 {
            description += " \(conditions) "
        }
        
        
        NSLog(description + "@@@@" + String(showIndex))
        return description
    }
}

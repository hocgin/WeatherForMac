//
//  Custom.swift
//  WeacherForMac
//
//  Created by hocgin on 14/02/2017.
//  Copyright © 2017 hocgin. All rights reserved.
//

import Foundation
//18x18这里写图片描述, 36x36(@2x)这里写图片描述, 54x54(@3x)
class Custom {
    static let units:[String:String] = [
        "metric": "°C",
        "imperial": "°F"
    ]
    static let languages:[String:String] = [
        "Catalan": "ca",
        "Croatian": "hr",
        "Turkish": "tr",
        "Chinese Simplified": "zh",
        "Chinese Traditional": "zh_tw",
        "Swedish": "sv",
        "Bulgarian": "bg",
        "French": "fr",
        "Dutch": "nl",
        "Finnish": "fi",
        "Polish": "pl",
        "Romanian": "ro",
        "English": "en",
        "Italian": "it",
        "Spanish": "es",
        "Ukrainian": "uk",
        "Portuguese": "pt",
        "Russian": "ru"
    ]
    
    static func getCity() -> String{
        return UserDefaults.standard.string(forKey: "city") ?? "Quanzhou"
    }
    
    static func getAppID() -> String{
        return UserDefaults.standard.string(forKey: "Jappid") ?? "e807b2d26a03cd8c31bde325ff85e0b6"
    }
    
    static func getUnit() -> String{
        let unit:String! = UserDefaults.standard.string(forKey: "unit")
        if !units.keys.contains(unit) {
            return "metric";
        }
        return unit
    }
    
    static func getLang() -> String{
        return UserDefaults.standard.string(forKey: "lang") ?? "zh"
    }
    
    static func getTime() -> Int{
        let time = UserDefaults.standard.integer(forKey: "time")
        return  time < 60 ? 1 * 20 * 60: time
    }
    
    static func getShowIndex() -> Int{
        return UserDefaults.standard.integer(forKey: "showIndex") // default 0
    }
}

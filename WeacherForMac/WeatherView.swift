//
//  WeatherView.swift
//  DemoBar
//
//  Created by hocgin on 13/02/2017.
//  Copyright © 2017 hocgin. All rights reserved.
//

import Cocoa

class WeatherView: NSView {
    
    @IBOutlet weak var weatherIcon: NSImageView!
    @IBOutlet weak var weatherTemp: NSTextField!
    @IBOutlet weak var weatherCity: NSTextField!
 
    @IBOutlet weak var sunEndView: NSTextFieldCell!
    @IBOutlet weak var sunStartView: NSTextFieldCell!
    func update(weather:Weather) -> Void {
        // do UI updates on the main thread
        DispatchQueue.main.async {
//            self.weatherIcon?.image = NSImage(named: weather.icon)
            self.weatherIcon?.image = NSImage(named: "zy" + weather.icon)
            self.weatherCity.stringValue = weather.city
            self.weatherTemp.stringValue = "\(Int(weather.currentTemp))°C \(weather.conditions)"
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            self.sunEndView.stringValue = formatter.string(from: Date(timeIntervalSince1970:TimeInterval(weather.sunset)) as Date)
            self.sunStartView.stringValue = formatter.string(from: Date(timeIntervalSince1970:TimeInterval(weather.sunrise)) as Date)
        }
        
    }
}

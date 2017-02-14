//
//  StatusMenuBarController.swift
//  DemoBar
//
//  Created by hocgin on 13/02/2017.
//  Copyright © 2017 hocgin. All rights reserved.
//

import Cocoa

class StatusMenuBarController: NSObject, PreferencesWindowDelegate {
    // 默认查询城市
    static let DEFAULT_CITY = "Seattle, WA"
    // 绑定组件
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var weatherView: WeatherView!
    var preferencesWindow: PreferencesWindow!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    // awakeFromNib 从xib或者storyboard加载完毕就会调用
    override func awakeFromNib() {
        // 设置 状态栏 中的托盘图标的样式和文字
        let icon = NSImage(named: "status-bar-icon")
        icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = statusMenu
        if let weatherMenuItem = self.statusMenu.item(withTitle: "Weather Description"){
            //weatherMenuItem.title = weather.description
            weatherMenuItem.view = self.weatherView
            
        }
        // Preferences
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        updateWeather()
        
        // 20min更新一次
        let timer:Timer = Timer.scheduledTimer(timeInterval: TimeInterval(Custom.getTime()),
                                               target: self,
                                               selector: #selector(StatusMenuBarController.updateWeather),
                                               userInfo: nil,
                                               repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        
    }
    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
    
    // 响应点击事件
    @IBAction func refreshClicked(_ sender: Any) {
        updateWeather()
    }
    
    @IBAction func preferencesClicked(_ sender: Any) {
        preferencesWindow.showWindow(nil)
    }
    
    func updateWeather(){
        NSLog("\n##正在更新天气ing##\n")
        let api = OpenWeather()
        let defaults = UserDefaults.standard
        api.fetchWeather(query: defaults.string(forKey: "city") ?? StatusMenuBarController.DEFAULT_CITY){ (weather)->Void in
            // NSLog(weather.description)
            self.weatherView.update(weather: weather)
            self.statusItem.title = weather.description()
            self.statusItem.image = NSImage(named: weather.icon)
        }
    }
    
    @IBAction func openURL(_ sender: NSMenuItem) {
        NSLog(sender.identifier!)
        let urls = [
            "http://github.com/hocgin",
            "http://weibo.com/hocgin",
            "https://hocg.in"
        ]
        
        if let url = URL(string: urls[sender.tag]), NSWorkspace.shared().open(url) {
            print("default browser was successfully opened")
        }
    }
    // set city
    func update() {
        updateWeather()
    }
}

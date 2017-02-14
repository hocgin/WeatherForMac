//
//  PreferencesWindow.swift
//  DemoBar
//
//  Created by hocgin on 14/02/2017.
//  Copyright © 2017 hocgin. All rights reserved.
//

import Cocoa

class PreferencesWindow: NSWindowController, NSWindowDelegate {
    // 城市／国家／温度／是否显示文字描述／更新间隔／APP ID
    
    
    @IBOutlet weak var cityView: NSTextField!
    @IBOutlet weak var appidView: NSSecureTextField!
    @IBOutlet weak var unitView: NSPopUpButton!
    @IBOutlet weak var langView: NSPopUpButton!
    @IBOutlet weak var timeView: NSTextField!
    
    @IBOutlet weak var hasCityView: NSButton!
    @IBOutlet weak var hasTempView: NSButton!
    @IBOutlet weak var hasDescView: NSButton!
    
    var delegate:PreferencesWindowDelegate?
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.cityView.stringValue = Custom.getCity()
        self.appidView.stringValue = Custom.getAppID()
        self.timeView.stringValue = String(Custom.getTime())
        self.unitView.selectItem(withTitle: Custom.units[Custom.getUnit()]!)
        // 初始化和设置语言
        let lang = Custom.getLang()
        self.langView.addItems(withTitles: Array(Custom.languages.keys))
        for (k, v) in Custom.languages {
            if v == lang {
                self.langView.selectItem(withTitle: k)
            }
        }
        // 设置状态栏显示
        var showIndex = Custom.getShowIndex()
        if showIndex % 10 == 1 {
            hasCityView.state = NSOnState
            showIndex-=1
        }
        if showIndex % 100 == 10 {
            hasTempView.state = NSOnState
            showIndex-=10
        }
        if showIndex % 1000 == 1 {
            hasDescView.state = NSOnState
        }
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    // 保存
    @IBAction func saveClicked(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.setValue(cityView.stringValue, forKey: "city")
        defaults.setValue(appidView.stringValue, forKey: "Jappid")
        defaults.setValue(timeView.stringValue, forKey: "Jtime")
        defaults.setValue(Custom.languages[(langView.selectedItem?.title)!], forKey: "lang")
        defaults.setValue(unitView.selectedItem?.identifier, forKey: "unit")
        
        var index = 0
        if hasCityView.state == NSOnState{
            index += 1
        }
        
        if hasTempView.state == NSOnState {
            index += 10
        }
        
        if hasDescView.state == NSOnState {
            index += 100
        }
        defaults.setValue(index, forKey: "showIndex")
        delegate?.update()
        self.close()
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.close()
    }
}

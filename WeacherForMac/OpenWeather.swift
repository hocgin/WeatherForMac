//
//  OpenWeather.swift
//  DemoBar
//
//  Created by hocgin on 13/02/2017.
//  Copyright © 2017 hocgin. All rights reserved.
//

import Foundation

class OpenWeather{
    let BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
    
    
    /**
     * 查询天气
     * , success: (Weather) -> Void    是回调实现
     **/
    func fetchWeather(query: String, success:@escaping (Weather)->Void) {
        let session = URLSession.shared
        let q = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let url = URL.init(string: "\(BASE_URL)?APPID=\(Custom.getAppID())&units=\(Custom.getUnit())&q=\(q!)&lang=\(Custom.getLang())")
        let request = NSMutableURLRequest.init(url: url!)
        request.timeoutInterval = 30
        //请求方式，跟OC一样的
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest){(data, response, err)->Void in
            if let error = err {
                NSLog("weather api error: \(error)")
            }
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200: // 正常
//                    let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
//                    NSLog(dataString)
                    if let weather = self.getWeather(data: data!) {
                        //NSLog("\(weather)")
                        // self.delegate.update(weather: weather)
                        success(weather)
                    }
                case 401: // APP ID 过期
                    NSLog("weather api returned an 'unauthorized' response. Did you set your API key?")
                default:
                    NSLog("weather api returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
                }
            }
        }
       task.resume()
    }
    
    // 转 json 为 Struts 的 Weather
    func getWeather(data:Data) -> Weather? {
        typealias JSONDict = [String:AnyObject]
        let json:JSONDict
        do{
            json = try JSONSerialization.jsonObject(with: data) as! JSONDict
        }catch{
            return nil
        }
        var mainDict = json["main"] as!JSONDict
        var weatherList = json["weather"] as! [JSONDict]
        var weatherDict = weatherList[0]
        var sys = json["sys"] as! JSONDict
        
        let weather = Weather(
            city: json["name"] as! String,
            currentTemp: mainDict["temp"] as! Float,
            conditions: weatherDict["description"] as! String,
            icon: weatherDict["icon"] as! String,
            sunrise: sys["sunrise"] as! Int,
            sunset: sys["sunset"] as! Int
        )
        return weather
    }
}

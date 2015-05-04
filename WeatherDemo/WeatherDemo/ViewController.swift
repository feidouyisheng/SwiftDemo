//
//  ViewController.swift
//  WeatherDemo
//
//  Created by ZLMac on 15-4-16.
//  Copyright (c) 2015年 lgwh. All rights reserved.
//

import UIKit

struct Weather {
    var city: String?
    var weather: String?
    var temp: String?
}
class ViewController: UIViewController {

    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var lableCity: UILabel!
    
    var weatherData: Weather? {
        didSet {
            configView()
        }
    }
    func configView() {
        lableCity.text = self.weatherData?.city
        labelWeather.text = self.weatherData?.weather
        labelTemp.text = self.weatherData?.temp
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData(169)
    }

    @IBAction func getOtherCityWeather(sender: UIButton) {
        getWeatherData(sender.tag)
    }
    
    
    func getWeatherData(index: Int) {
    
        let url = NSURL(string: "http://api.k780.com:88/?app=weather.today&weaid=\(index)&appkey=11321&sign=ffe7858a5e14adffdcddf6eb2e2bb79d&format=json")
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 10
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, _, error) -> Void in
            
            if error == nil {
                
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as? NSDictionary {
                    let weather = (json.valueForKey("result") as?NSDictionary).map {
                        Weather(city: $0["citynm"] as? String, weather: $0["weather"] as? String, temp: $0["temperature"] as? String)
                    }
                    println(json)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.weatherData = weather
                    })
                }
            }else {
                println(error)
            }
            
        })
        
        //执行任务
        task.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


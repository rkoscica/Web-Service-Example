//
//  ViewController.swift
//  Web Service Example
//
//  Created by Rosalyn Koscica on 11/19/15.
//  Copyright © 2015 Rosalyn Koscica. All rights reserved.
//
// API Code:    4e82234da75c8c3c0e87d8f22c5eebac

import UIKit
//import SwiftyJSON

class ViewController: UIViewController {

    
    @IBOutlet weak var forecastLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = AFHTTPRequestOperationManager()
        
        self.forecastLabel.text = ""

        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        
        manager.GET( "http://api.openweathermap.org/data/2.5/forecast/daily?q=Philadelphia&mode=json&units=metric&cnt=1&appid=4e82234da75c8c3c0e87d8f22c5eebac",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation?,responseObject: AnyObject!) in
                print("Response: " + responseObject.description)
//SwiftyJSON code
                let json = JSON(responseObject)
                if let forecast = json["list"][0]["weather"][0]["description"].string {
                    self.forecastLabel.text = forecast
                    activityIndicatorView.removeFromSuperview()
                }
                if let temperature = json["list"][0]["temp"][0]["day"].string{
                    if Double(temperature) < 23.00 {
                        self.view.backgroundColor = UIColor.greenColor()
                    } else {
                        self.view.backgroundColor = UIColor.redColor()
                    }
                }
                
            },
            failure: { (operation:AFHTTPRequestOperation?,error:NSError!) in
                print("Error: " + error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

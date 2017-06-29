//
//  ViewController.swift
//  API demo weather app
//
//  Created by David Kooistra on 5/25/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBAction func FindWeatherPressed(_ sender: Any) {
    
        if let url = URL(string: "http://samples.openweathermap.org/data/2.5/weather?q=" + textField.text! + "&appid=05433cfdcb8de0bea2a5460d9ff754ba") {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print(error)
            }
            else {
                if let urlContent = data {
                    
                    do {
                        //url Content will be JSON
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(jsonResult)
                        print(jsonResult["name"])
                        
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                            
                            DispatchQueue.main.sync(execute: {
                                
                                self.weatherDescription.text = "The weather in \(jsonResult["name"])\n is \(description)"
                                
                            })
                                
                            
                        }
                        else{
                            print("No description")
                        }
                        
                    } catch {
                        print("JSON processing failed")
                    }
                }
                else {
                    print("No data")
                }
        
            }
            
            
        }
        
        task.resume()
        }
        else {
            print("Could not find weather for that city -- Please try another")
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        weatherDescription.text = ""
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


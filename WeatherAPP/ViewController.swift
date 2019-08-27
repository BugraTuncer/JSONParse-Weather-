//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Buğra Tunçer on 22.07.2019.
//  Copyright © 2019 Buğra Tunçer. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
   
   
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    override func viewDidLoad() {
//        let JSONResults=NetworkProcessors()
//        JSONResults.getStuff()
        getStuff()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func refreshClicked(_ sender: Any) {
        getStuff()
    }
    func getStuff()
    {
//        let main=ViewController()
        let url = URL(string: "https://api.darksky.net/forecast/c9143e40536fd9c17f2f738a401c45ab/37.8267,-122.4233")
        let session = URLSession.shared
        let task=session.dataTask(with: url!) { (data, response, err) in
            if data != nil
            {
                do
                {
                    let JSONResult=try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary <String,AnyObject>
                    
                        DispatchQueue.main.async {
                        let stuff=JSONResult["currently"] as! [String : AnyObject]
                        let tempature=stuff["temperature"] as! Double
                        let summary=stuff["summary"] as! String
                        if summary == "Partly Cloudy"
                        {
                            self.backgroundImage.image = UIImage(named: "partlycloudy.jpeg")
                        }
                        if summary == "Clear"
                        {
                            self.backgroundImage.image = UIImage(named: "clear.jpg")
                        }
                        if summary == "Sunny"
                        {
                            self.backgroundImage.image = UIImage(named: "sunny.jpg")
                        }
                        self.nameLabel.text="Los Angeles"
                        self.tempatureLabel.text=String(tempature)
                        self.summaryLabel.text=summary
                        print(tempature)
                        //let windSpeed=stuff["windSpeed"] as! String
                        // let icon=stuff["icon"] as! String
                    }
                }
                catch
                {
                    print(err?.localizedDescription)
                }
                
            }
        }
        task.resume()
    }
}

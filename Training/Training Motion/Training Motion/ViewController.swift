//
//  ViewController.swift
//  Training Motion
//
//  Created by Jeff on 03/08/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import CoreMotion
import Foundation

class ViewController: UIViewController {

    
    let CM = CMMotionManager()
    var timer : Timer?
    var datamotion : [String:[Double]] = ["x":[0],"y":[0],"z":[0]]
    var user = String()
    
    @IBOutlet weak var userText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CM.accelerometerUpdateInterval=1/10
        userText.text!=user

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    @IBAction func startTracking(_ sender: UIButton) {
        
        if(sender.title(for: .normal)! == "Start tracking"){
            sender.setTitle("Stop tracking", for: .normal)
             datamotion  = ["x":[0],"y":[0],"z":[0]]
            CM.startAccelerometerUpdates(to: OperationQueue.current! ){ (data, error) in
                if let mydata = data
                {
                    let x = mydata.acceleration.x
                    let y = mydata.acceleration.y
                    let z = mydata.acceleration.z
                    
                    self.datamotion["x"]!.append(x)
                    self.datamotion["y"]!.append(y)
                    self.datamotion["z"]!.append(z)
                }
            }
        }else{
            sender.setTitle("Start tracking", for: .normal)
            CM.stopAccelerometerUpdates()
            SendData()
            datamotion  = ["x":[0],"y":[0],"z":[0]]

        }
        
        
 
        }

    func SendData() {
        
        
        do {
            let url = URL(string: "http://137.74.168.147/json")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            
            //            let datamotion2=["username":"jeff", "password":"qin"]
            
            
            let myjson = try! JSONSerialization.data(withJSONObject: datamotion, options: .prettyPrinted)
            let valid = JSONSerialization.isValidJSONObject(myjson)
            print(valid)
            
            let decoded = try JSONSerialization.jsonObject(with: myjson, options: [])
            // here "decoded" is of type `Any`, decoded from JSON data
            
            // you can now cast it with the right type
            if let dictFromJSON = decoded as? [String:String] {
                
                print(dictFromJSON)
            }
            
            
            request.httpBody = myjson
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil
                {print(error)}
                else{
                    if let content = data {
                        do {
                            let myjson = try JSONSerialization.jsonObject(with: content, options: []) as AnyObject!
                            print(myjson!)
                        }
                            
                        catch{
                            print("error from api")
                            print(content)}
                        
                    }
                    
                }}
            task.resume()
            //p/rint(myjson)
            
        }catch {
            print("error from json")
            print(error)
        }
        
        
        
        //request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
    }
    
    
    

}


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

    override func viewDidLoad() {
        super.viewDidLoad()
        CM.deviceMotionUpdateInterval=1
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    @IBAction func startTracking(_ sender: UIButton) {
        
        if(sender.title(for: .normal)! == "Start tracking"){
                sender.setTitle("Stop tracking", for: .normal)
            func helloWorldTimer () {
                 timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.tracking), userInfo: nil, repeats: true)}
            helloWorldTimer()
            
            
        }else{
            sender.setTitle("Start tracking", for: .normal)
             timer?.invalidate()
            endTracking()
        }
    }
    
    
    func tracking()
    {

        CM.startAccelerometerUpdates()
        
        if let ee = CM.accelerometerData?.acceleration.x
        {
            let x = CM.accelerometerData?.acceleration.x
            let y = CM.accelerometerData?.acceleration.y
            let z = CM.accelerometerData?.acceleration.z

            datamotion["x"]!.append(x!)
            datamotion["y"]!.append(y!)
            datamotion["z"]!.append(z!)
            
        }else{
        print("data is nil")
        }

    
    }

    func endTracking()
    {
        
        print(datamotion)
        CM.stopAccelerometerUpdates()
        
        
    }

    

}


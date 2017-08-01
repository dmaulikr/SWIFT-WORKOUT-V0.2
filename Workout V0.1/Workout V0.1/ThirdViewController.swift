//
//  ThirdViewController.swift
//  Workout V0.1
//
//  Created by Jeff on 25/07/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
@IBOutlet weak var tableAPI: UITableView!
    
    
    var serieAPI = [Int: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableAPI.register(UITableViewCell.self, forCellReuseIdentifier: "cellAPI")
        tableAPI.delegate = self
        tableAPI.dataSource = self
        
        // Do any additional setup after loading the view.
        
        
        let url = URL(string: "http://137.74.168.147/")
        let task=URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
                {print("error")}
            else{
                if let content = data {
                    do {
                    let myjson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        
                        print(myjson)
                        let serie = myjson as? NSDictionary
                        
                        self.serieAPI[0]=String(describing: serie?["serie1"]!)
                        self.serieAPI[1]=String(describing: serie?["serie2"]!)
                        self.serieAPI[2]=String(describing: serie?["serie3"]!)
                        
                      //  print(serie)
                     //   self.serieAPI!.append(String(myjson["serie1"]))
                   //     self.serieAPI.append(serie)
                        print("append done")
                        self.tableAPI.reloadData()

                    }
                    catch{}
                
                }
            
            }
        }
        task.resume()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serieAPI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableAPI.dequeueReusableCell(withIdentifier: "cellAPI", for: indexPath)
        cell.textLabel?.text=self.serieAPI[indexPath.row]
        
        return(cell)
    }

}

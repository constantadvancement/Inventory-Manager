//
//  ServerViewController.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/27/20.
//

import Cocoa

class ServerViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(DeviceInfo.shared.getInfo())
//        print(LocationInfo.shared.getInfo())
        
        let http = HttpClient()
        http.POST(url: "http://localhost:3000/device/1/info", body: DeviceInfo.shared.getInfo()) { (err: Error?, data: Data?) in
            guard err == nil else {
                print("Server or client error has occured!")
                // Todo handle err?
                return
            }
            
            let result = String(data: data!, encoding: .utf8)
            print("Result was: \(String((result?.toBool)!))")
            return
        }
        
    }
    
    // Navigation button actions
    
    @IBAction func backButton(_ sender: Any) {
        if let controller = self.storyboard?.instantiateController(withIdentifier: "LocationViewController") as? LocationViewController {
            self.view.window?.contentViewController = controller
        }
    }
    
}

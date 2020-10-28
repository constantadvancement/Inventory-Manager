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
        
        print(DeviceInfo.shared.getInfo())
        print(LocationInfo.shared.getInfo())
    }
    
    // Navigation button actions
    
    @IBAction func backButton(_ sender: Any) {
        if let controller = self.storyboard?.instantiateController(withIdentifier: "LocationViewController") as? LocationViewController {
            self.view.window?.contentViewController = controller
        }
    }
    
}

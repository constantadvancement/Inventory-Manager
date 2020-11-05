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
        
        // View styles
        view.wantsLayer = true
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 650, height: 74)
        layer.backgroundColor = NSColor.darkGray.cgColor
        layer.opacity = 0.4
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: 74, width: 650, height: 1)
        borderLayer.backgroundColor = NSColor.black.cgColor
        
        layer.addSublayer(borderLayer)
        view.layer?.addSublayer(layer)
        
        // HTTP requests to register this device
        let http = HttpClient()
        http.POST(url: "http://localhost:3000/register/device/info", body: DeviceInfo.shared.getInfo()) { (err: Error?, data: Data?) in
            guard err == nil else {
                print("Server or client error has occured!")
                // Todo handle err?
                return
            }
            
            let defaults = UserDefaults.standard
            if let result = String(data: data!, encoding: .utf8)?.toBool {
                defaults.setValue(result, forKey: "DeviceInfo")
                
                print("Got result \(result) for device info")
            }
        }
        http.POST(url: "http://localhost:3000/register/device/location", body: LocationInfo.shared.getInfo()) { (err: Error?, data: Data?) in
            guard err == nil else {
                print("Server or client error has occured!")
                // Todo handle err?
                return
            }
            
            let defaults = UserDefaults.standard
            if let result = String(data: data!, encoding: .utf8)?.toBool {
                defaults.setValue(result, forKey: "LocationInfo")
                
                print("Got result \(result) for location info")
            }
        }
    }
    
    // Navigation button actions
    
    @IBAction func backButton(_ sender: Any) {
        if let controller = self.storyboard?.instantiateController(withIdentifier: "LocationViewController") as? LocationViewController {
            self.view.window?.contentViewController = controller
        }
    }
    
}

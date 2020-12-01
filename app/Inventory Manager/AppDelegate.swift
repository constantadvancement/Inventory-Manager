//
//  AppDelegate.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/20/20.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var locationService: LocationService?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mode = CommandLine.arguments.last!
        
        // Determines the current launch mode
        switch mode {
        case "setup":
            // Application launched in setup mode
            print("Application launched in setup mode.")
            
            // Show setup window; application runs in foreground
            let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
            let window = storyboard.instantiateController(withIdentifier: "MainWindow") as! NSWindowController
            let controller = storyboard.instantiateController(withIdentifier: "HomeViewController") as! NSViewController

            window.contentViewController = controller
            window.showWindow(self)
        default:
            // Application launched in background mode (setup should be complete)
            print("Application launched in background mode.")
            
            // No window; application runs in background
            
            // TODO change timer interval
            let timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(pingLocation), userInfo: nil, repeats: true)
            timer.tolerance = 2.0
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        print("CA Inventory Manager has been terminated!")
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    // Background location update methods
    
    @objc func pingLocation() {
        print("\nPinging location...")
        
        // Adds location service observers
        let nc = NotificationCenter.default
        // Location service status notifications
        nc.addObserver(self, selector: #selector(authorizedStatus), name: .authorized, object: nil)
        nc.addObserver(self, selector: #selector(deniedStatus), name: .denied, object: nil)
        nc.addObserver(self, selector: #selector(notDeterminedStatus), name: .notDetermined, object: nil)
        
        // Location data notifications
        nc.addObserver(self, selector: #selector(locationFound), name: .locationFound, object: nil)
        nc.addObserver(self, selector: #selector(addressFound), name: .addressFound, object: nil)
        
        // Location error notification
        nc.addObserver(self, selector: #selector(locationServiceError), name: .error, object: nil)
        
        // Requests the user's current location
        locationService = LocationService()
        locationService?.startUpdatingLocation()
    }
    
    // Location service notification handlers
    
    @objc func authorizedStatus() {
        print("Location service status authorized.")
        
        // TODO -- POST to server this device's location service status
    }
    
    @objc func deniedStatus() {
        print("Location service status denied or restricted.")
        
        // TODO -- POST to server this device's location service status
    }
    
    @objc func notDeterminedStatus() {
        print("Location service status not determined.")
        
        // TODO -- POST to server this device's location service status
    }
    
    @objc func locationFound() {
        print("Location was found!")
        
        // TODO -- POST to server new location data ... if this is being tracked
    }
    
    @objc func addressFound() {
        print("Address was found!")
        
        // Removes location service observers
        let nc = NotificationCenter.default
        // Location service error notification
        nc.removeObserver(self, name: .error, object: nil)
        
        // Location service status notifications
        nc.removeObserver(self, name: .authorized, object: nil)
        nc.removeObserver(self, name: .denied, object: nil)
        nc.removeObserver(self, name: .notDetermined, object: nil)
        
        // Location data notifications
        nc.removeObserver(self, name: .locationFound, object: nil)
        nc.removeObserver(self, name: .addressFound, object: nil)
        
        // TODO -- POST to server new address data
        let http = HttpClient()
        http.POST(url: "http://localhost:3000/register/device/location", body: Location.shared.getInfo()) { (err: Error?, data: Data?) in
            guard err == nil else {
                print("Server or client error has occured!")
                // Todo handle err?
                return
            }
            
//            let defaults = UserDefaults.standard
//            if let result = String(data: data!, encoding: .utf8)?.toBool {
//                defaults.setValue(result, forKey: "LocationInfo")
//                
//                print("Got result \(result) for location info")
//            }
        }
    }
    
    @objc func locationServiceError() {
        print("Location service error occured")
        
        // Removes location service observers
        let nc = NotificationCenter.default
        // Location service error notification
        nc.removeObserver(self, name: .error, object: nil)
        
        // Location service status notifications
        nc.removeObserver(self, name: .authorized, object: nil)
        nc.removeObserver(self, name: .denied, object: nil)
        nc.removeObserver(self, name: .notDetermined, object: nil)
        
        // Location data notifications
        nc.removeObserver(self, name: .locationFound, object: nil)
        nc.removeObserver(self, name: .addressFound, object: nil)
    }
    
}

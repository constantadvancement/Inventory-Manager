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
        let defaults = UserDefaults.standard
    
        // TODO get user defaults value (setupFinished -- a boolean value... something like that)
//        let mode = defaults.object(forKey: "mode") as? String
//
//        switch mode {
//        case nil:
//            print("run app as sudo")
//            let commandLine = CommandLineService()
//            let result = commandLine.executeAsRootNoCredentials(command: "sudo \(Bundle.main.bundlePath)/Contents/MacOS/InventoryManager")
//
//            print(result)
//
//            NSApp.terminate(self)
//        case "foreground":
//            print("run in foreground")
//        case "background":
//            print("run in background")
//        default:
//            print("This case should never occur")
//        }
        
        if true {
            // Show setup window; application runs in foreground
            let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
            let window = storyboard.instantiateController(withIdentifier: "MainWindow") as! NSWindowController
            let controller = storyboard.instantiateController(withIdentifier: "HomeViewController") as! NSViewController

            window.contentViewController = controller
            window.showWindow(self)
        } else {
            // No window; application runs in background
            let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(pingLocation), userInfo: nil, repeats: true)
            timer.tolerance = 2.0
        }
    }
    
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
        http.POST(url: "http://localhost:3000/register/device/location", body: LocationInfo.shared.getInfo()) { (err: Error?, data: Data?) in
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
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        print("I terminated.")
    }
    
}


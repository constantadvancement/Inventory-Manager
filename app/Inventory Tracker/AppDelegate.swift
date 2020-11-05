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
        if let deviceInfo = defaults.value(forKey: "DeviceInfo"), let locationInfo = defaults.value(forKey: "LocationInfo") {
            let deviceInfoResult = deviceInfo as! Bool
            let locationInfoResult = locationInfo as! Bool
            
            if deviceInfoResult == true, locationInfoResult == true {
                // Device is properly registered, run app in the background
                print("App running in the background...")
                
                // Closes the application window
                // TODO -- create prompt window saying that the app is running in the background (?)
                let application = NSApplication.shared.windows.first
                application?.close()
                
                // TODO
                // Begin running background processes (periodic location ping)
                let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(pingLocation), userInfo: nil, repeats: true)
                timer.tolerance = 2.0
            }
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
        nc.addObserver(self, selector: #selector(locationError), name: .error, object: nil)
        
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
        
        // TODO -- POST to server new location data
    }
    
    @objc func addressFound() {
        print("Address was found!")
        
        // Removes location service observers
        let nc = NotificationCenter.default
        // Location error notification
        nc.removeObserver(self, name: .error, object: nil)
        
        // Location service status notifications
        nc.removeObserver(self, name: .authorized, object: nil)
        nc.removeObserver(self, name: .denied, object: nil)
        nc.removeObserver(self, name: .notDetermined, object: nil)
        
        // Location data notifications
        nc.removeObserver(self, name: .locationFound, object: nil)
        nc.removeObserver(self, name: .addressFound, object: nil)
        
        // TODO -- POST to server new address data
    }
    
    @objc func locationError() {
        print("Location error occured")
        
        // Removes location service observers
        let nc = NotificationCenter.default
        // Location error notification
        nc.removeObserver(self, name: .error, object: nil)
        
        // Location service status notifications
        nc.removeObserver(self, name: .authorized, object: nil)
        nc.removeObserver(self, name: .denied, object: nil)
        nc.removeObserver(self, name: .notDetermined, object: nil)
        
        // Location data notifications
        nc.removeObserver(self, name: .locationFound, object: nil)
        nc.removeObserver(self, name: .addressFound, object: nil)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        print("I terminated.")
    }


}


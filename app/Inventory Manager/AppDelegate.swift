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
    
    // Background location update functions
    
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
        print("Location service status authorized... Finding location...")
    }
    
    @objc func deniedStatus() {
        print("Location service status denied or restricted.")
        removeObservers()
        updateLocation()
    }
    
    @objc func notDeterminedStatus() {
        print("Location service status not determined.")
        removeObservers()
        updateLocation()
    }
    
    @objc func locationFound() {
        print("Location was found... Finding address...")
    }
    
    @objc func addressFound() {
        print("Address was found!")
        removeObservers()
        updateLocation()
    }
    
    @objc func locationServiceError() {
        print("Location service error occured.")
        removeObservers()
    }
    
    // Helper function
    
    // POSTs a location update to the CA Inventory Manager web server for this device
    func updateLocation() {
        if let serialNumber = getSerialNumber() {
            let http = HttpClient()
            http.POST(url: "http://localhost:3000/update/\(serialNumber)/location", body: Location.shared.getInfo()) { (err: Error?, data: Data?) in
                guard data != nil else {
                    // Failure; a server or client error occurred
                    print("Server or client error has occurred!")
                    return
                }
                
                if let result = String(data: data!, encoding: .utf8)?.toBool {
                    if result {
                        // Success; server returned true
                        print("Success! Location was updated.")
                        return
                    } else {
                        // Failure; server returned false
                        print("Failure! Location was not updated.")
                        return
                    }
                } else {
                    // Failure; server returned any unexpected value
                    print("Failure! Location was not updated.")
                    return
                }
            }
        }
    }
    
    // Returns this device's serial number
    func getSerialNumber() -> String? {
        let platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        guard let serialNumber = IORegistryEntryCreateCFProperty(platformExpert, "IOPlatformSerialNumber" as CFString, kCFAllocatorDefault, 0).takeRetainedValue() as? String else {
            return nil
        }
        IOObjectRelease(platformExpert)
        return serialNumber
    }
    
    // Removes all location service observers
    func removeObservers() {
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

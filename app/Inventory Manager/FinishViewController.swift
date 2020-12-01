//
//  ServerViewController.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/27/20.
//

import Cocoa

class FinishViewController: NSViewController {
    @IBOutlet var statusField: NSTextField!
    @IBOutlet var alertField: NSTextField!
    @IBOutlet var finishButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Applies basic view styles
        setStyles()
        
        statusField.stringValue = "Starting setup..."
        finishButton.isEnabled = false
        
        // Executes setup events
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            appSetup() { (result) in
                if result {
                    serverSetup() { (result) in
                        if result {
                            DispatchQueue.main.async { [self] in
                                statusField.stringValue = "Setup successfully completed!"
                                alertField.stringValue = "Restart this device to start the CA Inventory Manager!"
                                alertField.textColor = NSColor.systemRed
                                finishButton.isEnabled = true
                            }
                        } else {
                            DispatchQueue.main.async { [self] in
                                statusField.stringValue = "Setup failure!"
                                alertField.stringValue = "An error occurred while attempting to register this device with the CA Inventory Manager web server. Please try again!"
                                alertField.textColor = NSColor.systemRed
                                finishButton.isEnabled = true
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async { [self] in
                        statusField.stringValue = "Setup failure!"
                        alertField.stringValue = "An error occurred while attempting to write launchd files and/or creating the new admin user. Please try again!"
                        alertField.textColor = NSColor.systemRed
                        finishButton.isEnabled = true
                    }
                }
            }
        }
    }
    
    // Task setup handlers
    
    func appSetup(completion: @escaping (Bool) -> ()) {
        // Writes launchd plist to /Library/LaunchAgents/
        DispatchQueue.main.async { [self] in
            statusField.stringValue = "Writing launchd plist to /Library/LaunchAgents/..."
        }
        guard writeLaunchdPlist() else {
            print("FAILURE - did not write plist file")
            return completion(false)
        }

        // Writes the application bundle to /Users/Shared/CA/
        DispatchQueue.main.async { [self] in
            statusField.stringValue = "Writing application bundle to /Users/Shared/CA/..."
        }
        guard writeApplicationBundle() else {
            print("FAILURE - did not write application bundle")
            return completion(false)
        }
        
        // Creates the new admin user
        DispatchQueue.main.async { [self] in
            statusField.stringValue = "Creating new admin user..."
        }
        guard createUser() else {
            print("FAILURE -- did not create new user")
            return completion(false)
        }
        
        return completion(true)
    }
    
    func serverSetup(completion: @escaping (Bool) -> ()) {
        // POSTs device and location information to the server
        DispatchQueue.main.async { [self] in
            statusField.stringValue = "POSTing device and location information to server..."
        }
        POSTInformation() { (result) in
            return completion(result)
        }
    }
    
    // Task 1 - Launchd setup
    
    // Task 1A - writes the launchd plist to /Library/LaunchAgents
    func writeLaunchdPlist() -> Bool {
        // Reads launchd plist from app bundle
        guard let url = Bundle.main.url(
            forResource: "com.CAInventoryManager",
            withExtension: "plist"
        ) else {
            print("Error: no such file")
            return false
        }
    
        do {
            // Converts plist file to data
            let data = try Data(contentsOf: url)
            
            // Creates path to /Library/LaunchAgents
            let launchAgentsDirectory = try! FileManager.default.url(for: .libraryDirectory, in: .localDomainMask, appropriateFor: nil, create: true).appendingPathComponent("LaunchAgents").appendingPathComponent("com.CAInventoryManager").appendingPathExtension("plist")

            do {
                // Writes the plist file to /Library/LaunchAgents
                try data.write(to: launchAgentsDirectory)
                return true
            } catch let error as NSError {
                print("Error: \(error)")
                return false
            }
        } catch let error as NSError {
            print("Error: \(error)")
            return false
        }
    }
    
    // Task 1B - writes the application bundle to /Users/Shared/CA
    func writeApplicationBundle() -> Bool {
        // Creates a CA directory at /Users/Shared (if it does not already exist)
        let result = execute(command: "mkdir /Users/Shared/CA")
        if !result.isEmpty && !result.contains("File exists") {
            print("Error: creating /Users/Shared/CA directory")
            return false
        }
        // Writes the application bundle to /Users/Shared/CA
        if !execute(command: "cp -r \(Bundle.main.bundlePath) /Users/Shared/CA/").isEmpty {
            print("Error: writing application bundle to /Users/Shared/CA")
            return false
        }
        return true
    }
    
    // Task 2 - Creating the new admin user
    
    func createUser() -> Bool {
        let user = User.shared
        
        // Reads user information
        let primaryGroupID = user.primaryGroupID
        guard let fullname = user.fullName, let username = user.username, let password = user.password, let uniqueID = user.uniqueID else {
            return false
        }
        
        // Creates the new user
        if !execute(command: "dscl . -create /Users/\(username)").isEmpty {
            print("Error: step 1")
            return false
        }
        // Sets the new user's full name
        if !execute(command: "dscl . -create /Users/\(username) RealName \"\(fullname)\"").isEmpty {
            print("Error: step 2")
            return false
        }
        // Sets the new user's password
        if !execute(command: "dscl . -passwd /Users/\(username) \(password)").isEmpty {
            print("Error: step 3")
            return false
        }
        // Sets the new user's default shell (TODO)
        if !execute(command: "dscl . -create /Users/\(username) UserShell /bin/bash").isEmpty {
            print("Error: step 4")
            return false
        }
        if !execute(command: "dscl . -create /Users/\(username) UniqueID \(uniqueID)").isEmpty {
            print("Error: step 5")
            return false
        }
        if !execute(command: "dscl . -create /Users/\(username) PrimaryGroupID \(primaryGroupID)").isEmpty {
            print("Error: step 6")
            return false
        }
        if !execute(command: "dscl . -create /Users/\(username) NFSHomeDirectory /Users/\(username)").isEmpty {
            print("Error: step 7")
            return false
        }
        
        return true
    }
    
    // Task 3 - POST device and location information to server (synchronously)
    
    func POSTInformation(completion: @escaping (Bool) -> ()) {
        let http = HttpClient()
        
        // Device information
        http.POST(url: "http://localhost:3000/register/device/info", body: Device.shared.getInfo()) { (err: Error?, data: Data?) in
            guard err == nil else {
                // Failure; a server or client error occurred
                print("Server or client error has occurred!")
                return completion(false)
            }

            // TODO result from registering device info might instead be its registration ID so that the location POST can use this value to correlate both POSTs to the same device
            if let result = String(data: data!, encoding: .utf8)?.toBool {
                print("Got result \(result) when POSTing device information")
                
                if result {
                    // Location information
                    http.POST(url: "http://localhost:3000/register/device/location", body: Location.shared.getInfo()) { (err: Error?, data: Data?) in
                        guard err == nil else {
                            // Failure; a server or client error occurred
                            print("Server or client error has occurred!")
                            return completion(false)
                        }

                        if let result = String(data: data!, encoding: .utf8)?.toBool {
                            print("Got result \(result) when POSTing location information")
                            
                            if result {
                                return completion(true)
                            } else {
                                // Failure; server returned false (or a non-boolean value)
                                return completion(false)
                            }
                        }
                    }
                } else {
                    // Failure; server returned false (or a non-boolean value)
                    return completion(false)
                }
            }
        }
    }
    
    // Helper function
    
    func execute(command: String) -> String {
        var arguments:[String] = []
        arguments.append("-c")
        arguments.append(command)

        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = arguments

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        task.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()

        return String(data: data, encoding: .utf8)!
    }
    
    // Navigation button actions
    
    @IBAction func backButton(_ sender: Any) {
        if let controller = self.storyboard?.instantiateController(withIdentifier: "UserViewController") as? UserViewController {
            self.view.window?.contentViewController = controller
        }
    }
    
    @IBAction func finishButton(_ sender: Any) {
        // Terminates the application
        NSApp.terminate(self)
    }
    
    // Styles
    
    func setStyles() {
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
    }
    
}

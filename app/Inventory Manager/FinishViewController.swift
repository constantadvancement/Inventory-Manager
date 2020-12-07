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
        
        // Executes each setup event synchronously
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            
            // Task 1A
            DispatchQueue.main.async { [self] in
                statusField.stringValue = "Writing launchd plist to /Library/LaunchAgents/..."
            }
            writeLaunchdPlist() { (result) in
                if result {
                    
                    print("write plist success")
                    
                    // Task 1B
                    DispatchQueue.main.async { [self] in
                        statusField.stringValue = "Writing application bundle to /Users/Shared/CA/..."
                    }
                    writeApplicationBundle() { (result) in
                        if result {
                            
                            print("write app bundle success")
                            
                            // Task 2
                            DispatchQueue.main.async { [self] in
                                statusField.stringValue = "Creating new admin user..."
                            }
                            createUser() { (result) in
                                if result {
                                    
                                    print("create user success")
                                    
                                    // Task 3
                                    DispatchQueue.main.async { [self] in
                                        statusField.stringValue = "Registering device to server..."
                                    }
                                    registerDevice() { (result) in
                                        if result {
                                            
                                            print("register device success")
                                            
                                            
                                            // Success; setup is complete!
                                            DispatchQueue.main.async { [self] in
                                                statusField.stringValue = "Setup successfully completed!"
                                                alertField.stringValue = "Restart this device to start the CA Inventory Manager!"
                                                alertField.textColor = NSColor.systemRed
                                                finishButton.isEnabled = true
                                            }
                                        } else {
                                            // Failure; task 3 error
                                            DispatchQueue.main.async { [self] in
                                                statusField.stringValue = "Setup failed!"
                                                alertField.stringValue = "An error occurred while attempting to register this device with the CA Inventory Manager web server. Please exit and try again!"
                                                alertField.textColor = NSColor.systemRed
                                                finishButton.isEnabled = true
                                            }
                                        }
                                    }
                                } else {
                                    // Failure; task 2 error
                                    DispatchQueue.main.async { [self] in
                                        statusField.stringValue = "Setup failed!"
                                        alertField.stringValue = "An error occurred while attempting to create the new admin user. Please exit and try again!"
                                        alertField.textColor = NSColor.systemRed
                                        finishButton.isEnabled = true
                                    }
                                }
                            }
                        } else {
                            // Failure; task 1B error
                            DispatchQueue.main.async { [self] in
                                statusField.stringValue = "Setup failed!"
                                alertField.stringValue = "An error occurred while attempting to write the application bundle files. Please exit and try again!"
                                alertField.textColor = NSColor.systemRed
                                finishButton.isEnabled = true
                            }
                        }
                    }
                } else {
                    // Failure; task 1A error
                    DispatchQueue.main.async { [self] in
                        statusField.stringValue = "Setup failed!"
                        alertField.stringValue = "An error occurred while attempting to write the launchd files. Please exit and try again!"
                        alertField.textColor = NSColor.systemRed
                        finishButton.isEnabled = true
                    }
                }
            }
        }
    }
    
    // Setup Events 1A, 1B, 2, and 3...
    
    // Task 1 - Launchd setup
    
    // Task 1A - writes the launchd plist to /Library/LaunchAgents
    func writeLaunchdPlist(completionHandler: @escaping (Bool) -> ()) {
        // Reads launchd plist from app bundle
        guard let url = Bundle.main.url(
            forResource: "com.CAInventoryManager",
            withExtension: "plist"
        ) else {
            print("Error: no such file")
            return completionHandler(false)
        }
    
        do {
            // Converts plist file to data
            let data = try Data(contentsOf: url)
            
            // Creates path to /Library/LaunchAgents
            let launchAgentsDirectory = try! FileManager.default.url(for: .libraryDirectory, in: .localDomainMask, appropriateFor: nil, create: true).appendingPathComponent("LaunchAgents").appendingPathComponent("com.CAInventoryManager").appendingPathExtension("plist")

            do {
                // Writes the plist file to /Library/LaunchAgents
                try data.write(to: launchAgentsDirectory)
                return completionHandler(true)
            } catch let error as NSError {
                print("Error: \(error)")
                return completionHandler(false)
            }
        } catch let error as NSError {
            print("Error: \(error)")
            return completionHandler(false)
        }
    }
    
    // Task 1B - writes the application bundle to /Users/Shared/CA
    func writeApplicationBundle(completionHandler: @escaping (Bool) -> ()) {
        // Creates a CA directory at /Users/Shared (if it does not already exist)
        let result = execute(command: "mkdir /Users/Shared/CA")
        if !result.isEmpty && !result.contains("File exists") {
            print("Error: creating /Users/Shared/CA directory")
            return completionHandler(false)
        }
        // Writes the application bundle to /Users/Shared/CA
        if !execute(command: "cp -r \(Bundle.main.bundlePath) /Users/Shared/CA/").isEmpty {
            print("Error: writing application bundle to /Users/Shared/CA")
            return completionHandler(false)
        }
        return completionHandler(true)
    }
    
    // Task 2 - Creating the new admin user
    
    func createUser(completionHandler: @escaping (Bool) -> ()) {
        let user = User.shared
        
        // Reads user information
        let primaryGroupID = user.primaryGroupID
        guard let fullname = user.fullName, let username = user.username, let password = user.password, let uniqueID = user.uniqueID else {
            return completionHandler(false)
        }
        
        // Creates the new user
        if !execute(command: "dscl . -create /Users/\(username)").isEmpty {
            return completionHandler(false)
        }
        // Sets the new user's full name
        if !execute(command: "dscl . -create /Users/\(username) RealName \"\(fullname)\"").isEmpty {
            return completionHandler(false)
        }
        // Sets the new user's password
        if !execute(command: "dscl . -passwd /Users/\(username) \(password)").isEmpty {
            return completionHandler(false)
        }
        // Sets the new user's default shell (TODO)
        if !execute(command: "dscl . -create /Users/\(username) UserShell /bin/bash").isEmpty {
            return completionHandler(false)
        }
        if !execute(command: "dscl . -create /Users/\(username) UniqueID \(uniqueID)").isEmpty {
            return completionHandler(false)
        }
        if !execute(command: "dscl . -create /Users/\(username) PrimaryGroupID \(primaryGroupID)").isEmpty {
            return completionHandler(false)
        }
        if !execute(command: "dscl . -create /Users/\(username) NFSHomeDirectory /Users/\(username)").isEmpty {
            return completionHandler(false)
        }
        return completionHandler(true)
    }
    
    // Task 3 - Register this device with the CA Inventory Manager web server
    
    func registerDevice(completionHandler: @escaping (Bool) -> ()) {
        let http = HttpClient()
        http.POST(url: "http://localhost:3000/register/device", body: info()) { (err: Error?, data: Data?) in
            guard data != nil else {
                // Failure; a server or client error occurred
                print("Server or client error has occurred!")
                return completionHandler(false)
            }
            
            if let result = String(data: data!, encoding: .utf8)?.toBool {
                if result {
                    // Success; server returned true
                    print("Success! Device was registered.")
                    return completionHandler(true)
                } else {
                    // Failure; server returned false
                    print("Failure! Device was not registered.")
                    return completionHandler(false)
                }
            } else {
                // Failure; server returned any unexpected value
                print("Failure! Device was not registered.")
                return completionHandler(false)
            }
        }
    }
        
    // Helper functions
    
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
    
    func info() -> Data? {
        // Data models
        let device = Device.shared
        let location = Location.shared
        let user = User.shared
        
        var info = [String: String]()
        
        // Device info
        info["modelName"] = device.modelName
        info["modelIdentifier"] = device.modelIdentifier
        info["modelNumber"] = device.modelNumber
        info["serialNumber"] = device.serialNumber
        info["hardwareUUID"] = device.hardwareUUID
        
        // Location info
        info["timestamp"] = location.timestamp
        info["street"] = location.street
        info["city"] = location.city
        info["state"] = location.state
        info["zip"] = location.zip
        info["country"] = location.country
        if let coordinate = location.coordinate {
            info["latitude"] = String(coordinate.latitude)
            info["longitude"] = String(coordinate.longitude)
        }
        info["status"] = location.status
        
        // User info
        info["name"] = user.fullName
        
        do {
            return try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
    
    // Navigation button actions
    
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

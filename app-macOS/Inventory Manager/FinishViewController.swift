//
//  ServerViewController.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/27/20.
//

import Cocoa

class FinishViewController: NSViewController {
    @IBOutlet var exitButton: NSButton!
    
    @IBOutlet var statusField: NSTextField!
    @IBOutlet var alertField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Applies basic view styles
        setStyles()
        
        statusField.stringValue = "Performing setup events..."
        exitButton.isEnabled = false
        
        var tasks = [writeLaunchdPlist, writeApplicationBundle, createUser, registerDevice]
        
        // Removes the create user task if createUser is false (toggeable value)
        let user = User.shared
        if !user.createUser {
            tasks.remove(at: 2)
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            // Executes each setup event synchronously
            let group = DispatchGroup()
            var status = true
            tasks.forEach { task in
                // Executes the next task only if all previous tasks have succeeded
                if status {
                    group.enter() // Wait/block
                    task { (result) in
                        status = result
                        group.leave() // Continue
                    }
                }
            }
            
            group.notify(queue: .main) { [self] in
                if status {
                    statusField.stringValue = "Setup successfully completed!"
                    statusField.textColor = NSColor.systemGreen
                    alertField.stringValue = "Restart this device to start the CA Inventory Manager!"
                    exitButton.isEnabled = true
                } else {
                    statusField.stringValue = "Setup failed, please exit and try again!"
                    statusField.textColor = NSColor.systemRed
                    alertField.stringValue = "If setup issues persist please ensure that this device has not previously been registered and/or ensure that the CA Inventory Manager web server is online."
                    exitButton.isEnabled = true
                }
            }
        }
    }
    
    // Setup Events
    
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
        if !execute(command: "dscl . -create /Users/\(username) RealName \"\(fullname)\"").isEmpty {
            return completionHandler(false)
        }
        if !execute(command: "dscl . -passwd /Users/\(username) \(password)").isEmpty {
            return completionHandler(false)
        }
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
        http.POST(url: "\(Endpoints.development)/register/device", body: deviceRegistration()) { (err: Error?, data: Data?) in
            guard data != nil else {
                // Failure; a server or client error occurred
                print("Server or client error has occurred!")
                return completionHandler(false)
            }
            
            if let result = String(data: data!, encoding: .utf8)?.toBool {
                if result {
                    // Success; server returned true
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
    
    func deviceRegistration() -> Data? {
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
        
        // "Holder" info
        info["name"] = user.fullName
        info["email"] = user.email
        info["phone"] = user.phone
        
        do {
            return try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
    
    // Navigation button actions
    
    @IBAction func exitButton(_ sender: Any) {
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

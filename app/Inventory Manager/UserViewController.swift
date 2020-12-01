//
//  UserViewController.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 11/9/20.
//

import Cocoa

class UserViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet var continueButton: NSButton!
    @IBOutlet var fullNameField: NSTextField!
    @IBOutlet var passwordField: NSTextField!
    
    let defaultPassword = "constantadvancement!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Applies basic view styles
        setStyles()
        
        // Prevents text fields from being auto focused when the view first loads
        fullNameField.refusesFirstResponder = true
        passwordField.refusesFirstResponder = true
        
        let user = User.shared
        
        // Full name
        if let fullName = user.fullName {
            fullNameField.stringValue = fullName
        }
        
        // Password
        if let password = user.password {
            passwordField.stringValue = password
        } else {
            passwordField.stringValue = defaultPassword
            user.password = defaultPassword
        }
        
        // Unique ID
        if user.uniqueID == nil {
            user.uniqueID = getUniqueID()
        }
        
        // Enables/disables the continue button depending on the state of the User model
        if let fullName = user.fullName, !fullName.isEmpty, let password = user.password, !password.isEmpty {
            continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
        }
    }
    
    func getUniqueID() -> Int {
        let lastID = execute(command: "dscl . -list /Users UniqueID | awk '{print $2}' | sort -n | tail -1")
        return (lastID as NSString).integerValue + 1
    }
    
    // Text field delegate methods
    
    func controlTextDidChange(_ obj: Notification) {
        // Gets the value of each text field
        let fullName = fullNameField.stringValue
        let password = passwordField.stringValue
        
        // Saves user data to the User model
        let user = User.shared
        user.fullName = fullName
        user.username = fullName.lowercased().filter { !$0.isWhitespace }
        user.password = password
        
        // Enables/disables the continue button depending on the state of each text field
        if !fullName.isEmpty && !password.isEmpty {
            continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
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
        if let controller = self.storyboard?.instantiateController(withIdentifier: "LocationViewController") as? LocationViewController {
            self.view.window?.contentViewController = controller
        }
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if let controller = self.storyboard?.instantiateController(withIdentifier: "FinishViewController") as? FinishViewController {
            self.view.window?.contentViewController = controller
        }
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
        
        fullNameField.backgroundColor = NSColor.darkGray
        passwordField.backgroundColor = NSColor.darkGray
    }
}

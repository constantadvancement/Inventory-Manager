//
//  UserViewController.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 11/9/20.
//

import Cocoa

class UserViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet var finishButton: NSButton!
    
    @IBOutlet var fullNameField: NSTextField!
    @IBOutlet var emailField: NSTextField!
    @IBOutlet var phoneField: NSTextField!
    @IBOutlet var passwordField: NSTextField!
    @IBOutlet var passwordLabel: NSTextField!
    
    @IBOutlet var createUserCheckbox: NSButton!
    
    let defaultPassword = "constantadvancement!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Applies basic view styles
        setStyles()
        
        // Prevents text fields from being auto focused when the view first loads
        fullNameField.refusesFirstResponder = true
        passwordField.refusesFirstResponder = true
        emailField.refusesFirstResponder = true
        phoneField.refusesFirstResponder = true
        
        let user = User.shared
        
        // Full name
        if let fullName = user.fullName {
            fullNameField.stringValue = fullName
        }
        
        // Email
        if let email = user.email {
            emailField.stringValue = email
        }
        
        // Phone Number
        if let phone = user.phone {
            phoneField.stringValue = phone
        }
        
        // Password
        if let password = user.password {
            passwordField.stringValue = password
        } else {
            passwordField.stringValue = defaultPassword
            user.password = defaultPassword
        }
        
        // Create user (toggleable setting)
        if user.createUser {
            createUserCheckbox.state = .on
        } else {
            createUserCheckbox.state = .off
            passwordField.isEnabled = false
            passwordField.isHidden = true
            passwordLabel.isHidden = true
        }
        
        // Unique ID
        if user.uniqueID == nil {
            user.uniqueID = getUniqueID()
        }
        
        // Enables/disables the continue button depending on the state of the User model
        if let fullName = user.fullName, !fullName.isEmpty, let password = user.password, !password.isEmpty, let email = user.email, !email.isEmpty, let phone = user.phone, !phone.isEmpty {
            finishButton.isEnabled = true
        } else {
            finishButton.isEnabled = false
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
        let email = emailField.stringValue
        let phone = phoneField.stringValue
        let password = passwordField.stringValue
        
        // Saves user data to the User model
        let user = User.shared
        user.fullName = fullName
        user.username = fullName.lowercased().filter { !$0.isWhitespace }
        user.email = email
        user.phone = phone
        user.password = password
        
        // Enables/disables the continue button depending on the state of each text field and the checkbox
        if user.createUser {
            if !fullName.isEmpty && !email.isEmpty && !phone.isEmpty && !password.isEmpty {
                finishButton.isEnabled = true
            } else {
                finishButton.isEnabled = false
            }
        } else {
            if !fullName.isEmpty && !email.isEmpty && !phone.isEmpty {
                finishButton.isEnabled = true
            } else {
                finishButton.isEnabled = false
            }
        }
    }
    
    // Checkbox button
    
    @IBAction func createUser(_ sender: Any) {
        guard let checkbox = sender as? NSButton else { return }
        
        // Gets the value of each text field
        let fullName = fullNameField.stringValue
        let email = emailField.stringValue
        let phone = phoneField.stringValue
        let password = passwordField.stringValue
        
        let user = User.shared
        if checkbox.state == .on {
            user.createUser = true
            
            passwordField.isEnabled = true
            passwordField.isHidden = false
            passwordLabel.isHidden = false
            
            // Enables/disables the continue button depending on the state of each text field and this checkbox
            if !fullName.isEmpty && !email.isEmpty && !phone.isEmpty && !password.isEmpty {
                finishButton.isEnabled = true
            } else {
                finishButton.isEnabled = false
            }
        } else if checkbox.state == .off {
            user.createUser = false
            
            passwordField.isEnabled = false
            passwordField.isHidden = true
            passwordLabel.isHidden = true
            
            // Enables/disables the continue button depending on the state of each text field and this checkbox
            if !fullName.isEmpty && !email.isEmpty && !phone.isEmpty {
                finishButton.isEnabled = true
            } else {
                finishButton.isEnabled = false
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
        if let controller = self.storyboard?.instantiateController(withIdentifier: "LocationViewController") as? LocationViewController {
            self.view.window?.contentViewController = controller
        }
    }
    
    @IBAction func finishButton(_ sender: Any) {
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
        emailField.backgroundColor = NSColor.darkGray
        phoneField.backgroundColor = NSColor.darkGray
        passwordField.backgroundColor = NSColor.darkGray
    }
}

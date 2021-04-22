//
//  ProvisionView.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/20/20.
//

import Cocoa

class SystemViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet var continueButton: NSButton!
    
    @IBOutlet var modelNameField: NSTextField!
    @IBOutlet var modelIdentifierField: NSTextField!
    @IBOutlet var modelNumberField: NSTextField!
    @IBOutlet var serialNumberField: NSTextField!
    @IBOutlet var hardwareUUIDField: NSTextField!
    
    @IBOutlet var modelNameLabel: NSTextField!
    @IBOutlet var modelIdentifierLabel: NSTextField!
    @IBOutlet var modelNumberLabel: NSTextField!
    @IBOutlet var serialNumberLabel: NSTextField!
    @IBOutlet var hardwareUUIDLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Applies basic view styles
        setStyles()

        let device = Device.shared
        
        // Model name
        if let modelName = device.modelName {
            modelNameField.stringValue = modelName
        } else if let modelName = getModelName() {
            modelNameField.stringValue = modelName
            device.modelName = modelName
        }
        
        if modelNameField.stringValue.isEmpty {
            modelNameLabel.textColor = .systemRed
        } else {
            modelNameLabel.textColor = .white
        }
        
        // Model identifier
        if let modelIdentifier = device.modelIdentifier {
            modelIdentifierField.stringValue = modelIdentifier
        } else if let modelIdentifier = getModelIdentifier() {
            modelIdentifierField.stringValue = modelIdentifier
            device.modelIdentifier = modelIdentifier
        }
        
        if modelIdentifierField.stringValue.isEmpty {
            modelIdentifierLabel.textColor = .systemRed
        } else {
            modelIdentifierLabel.textColor = .white
        }
        
        // Model number
        if let modelNumber = device.modelNumber {
            modelNumberField.stringValue = modelNumber
        } else if let modelNumber = getModelNumber(for: device.modelIdentifier!) {
            modelNumberField.stringValue = modelNumber
            device.modelNumber = modelNumber
        }
        
        if modelNumberField.stringValue.isEmpty {
            modelNumberLabel.textColor = .systemRed
        } else {
            modelNumberLabel.textColor = .white
        }
        
        // Serial number
        if let serialNumber = device.serialNumber {
            serialNumberField.stringValue = serialNumber
        } else if let serialNumber = getSerialNumber() {
            serialNumberField.stringValue = serialNumber
            device.serialNumber = serialNumber
        }
        
        if serialNumberField.stringValue.isEmpty {
            serialNumberLabel.textColor = .systemRed
        } else {
            serialNumberLabel.textColor = .white
        }
        
        // Hardware UUID
        if let hardwareUUID = device.hardwareUUID {
            hardwareUUIDField.stringValue = hardwareUUID
        } else if let hardwareUUID = getHardwareUUID() {
            hardwareUUIDField.stringValue = hardwareUUID
            device.hardwareUUID = hardwareUUID
        }
        
        if hardwareUUIDField.stringValue.isEmpty {
            hardwareUUIDLabel.textColor = .systemRed
        } else {
            hardwareUUIDLabel.textColor = .white
        }
        
        // Enables/disables the continue button depending on the state of the Device model
        if let modelName = device.modelName, !modelName.isEmpty, let modelIdentifier = device.modelIdentifier, !modelIdentifier.isEmpty, let modelNumber = device.modelNumber, !modelNumber.isEmpty, let serialNumber = device.serialNumber, !serialNumber.isEmpty, let hardwareUUID = device.hardwareUUID, !hardwareUUID.isEmpty {
            continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
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
    
    // Returns this device's UUID (Universally Unique Identifier)
    func getHardwareUUID() -> String? {
        let platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        guard let UUID = IORegistryEntryCreateCFProperty(platformExpert, "IOPlatformUUID" as CFString, kCFAllocatorDefault, 0).takeRetainedValue() as? String else {
            return nil
        }
        IOObjectRelease(platformExpert)
        return UUID
    }
    
    // Returns this device's model identifier
    func getModelIdentifier() -> String? {
        let platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        guard let modelData = IORegistryEntryCreateCFProperty(platformExpert, "model" as CFString, kCFAllocatorDefault, 0).takeRetainedValue() as? Data else {
            return nil
        }
        guard let modelIdentifier = String(data: modelData, encoding: .utf8)?.trimmingCharacters(in: .controlCharacters) else {
            return nil
        }
        IOObjectRelease(platformExpert)
        return modelIdentifier
    }
    
    // Returns this device's model name
    func getModelName() -> String? {
        guard let modelInfo = Host.current().localizedName else { return nil }
        var modelSubstring = modelInfo.split(separator: " ")
        // removes this device's user from the `modelInfo` string (e.g. "<User>'s MacBook Pro" -> "Mackbook Pro")
        modelSubstring.removeFirst()
        let modelName = modelSubstring.joined(separator: " ")
        return modelName
    }
    
    // Returns this device's model number based on the model identifier
    func getModelNumber(for modelIdentifier: String) -> String? {
        switch modelIdentifier {
        // MacBook Pros (2016 - 2020)
        case "MacBookPro13,1": return "A1708"
        case "MacBookPro13,2": return "A1706"
        case "MacBookPro13,3": return "A1707"
            
        case "MacBookPro14,1": return "A1708"
        case "MacBookPro14,2": return "A1706"
        case "MacBookPro14,3": return "A1707"
            
        case "MacBookPro15,1": return "A1990"
        case "MacBookPro15,2": return "A1989"
        case "MacBookPro15,3": return "A1990"
        case "MacBookPro15,4": return "A2159"
            
        case "MacBookPro16,1": return "A2141"
        case "MacBookPro16,2": return "A2251"
        case "MacBookPro16,3": return "A2289"

        // MacBook Air (2015 - 2020)
        case "MacBookAir7,1": return "A1465"
        case "MacBookAir7,2": return "A1466"
            
        case "MacBookAir8,1": return "A1932"
        case "MacBookAir8,2": return "A1932"
            
        case "MacBookAir9,1": return "A2179"
            
        // MacBook (2015 - 2017)
        case "MacBook8,1": return "A1534"
            
        case "MacBook9,1": return "A1534"
            
        case "MacBook10,1": return "A1534"
        
        default: return nil
        }
    }
    
    // Text field delegate methods
    
    func controlTextDidChange(_ obj: Notification) {
        // Gets the value of each text field
        let modelName = modelNameField.stringValue
        let modelIdentifier = modelIdentifierField.stringValue
        let modelNumber = modelNumberField.stringValue
        let serialNumber = serialNumberField.stringValue
        let hardwareUUID = hardwareUUIDField.stringValue
        
        // Saves device data to the Device model
        let device = Device.shared
        device.modelName = modelName
        device.modelIdentifier = modelIdentifier
        device.modelNumber = modelNumber
        device.serialNumber = serialNumber
        device.hardwareUUID = hardwareUUID
        
        // Updates required text field label colors
        if modelName.isEmpty {
            modelNameLabel.textColor = .systemRed
        } else {
            modelNameLabel.textColor = .white
        }
        
        if modelIdentifier.isEmpty {
            modelIdentifierLabel.textColor = .systemRed
        } else {
            modelIdentifierLabel.textColor = .white
        }
        
        if modelNumber.isEmpty {
            modelNumberLabel.textColor = .systemRed
        } else {
            modelNumberLabel.textColor = .white
        }
        
        if serialNumber.isEmpty {
            serialNumberLabel.textColor = .systemRed
        } else {
            serialNumberLabel.textColor = .white
        }
        
        if hardwareUUID.isEmpty {
            hardwareUUIDLabel.textColor = .systemRed
        } else {
            hardwareUUIDLabel.textColor = .white
        }
        
        // Enables/disables the continue button depending on the state of each text field
        if !modelName.isEmpty && !modelIdentifier.isEmpty && !modelNumber.isEmpty && !serialNumber.isEmpty && !hardwareUUID.isEmpty {
            continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
        }
    }
    
    // Navigation button actions
    
    @IBAction func backButton(_ sender: Any) {
        if let controller = self.storyboard?.instantiateController(withIdentifier: "HomeViewController") as? HomeViewController {
            self.view.window?.contentViewController = controller
        }
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if let controller = self.storyboard?.instantiateController(withIdentifier: "LocationViewController") as? LocationViewController {
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
        
        modelNameField.backgroundColor = NSColor.darkGray
        modelIdentifierField.backgroundColor = NSColor.darkGray
        modelNumberField.backgroundColor = NSColor.darkGray
        serialNumberField.backgroundColor = NSColor.darkGray
        hardwareUUIDField.backgroundColor = NSColor.darkGray
    }
}

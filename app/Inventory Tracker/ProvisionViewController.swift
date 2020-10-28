//
//  ProvisionView.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/20/20.
//
// This view controller is responsible for gathering all provisioning data for this device. This includes the model name, model identifier, model number, serial number, and hardware UUID.

import Cocoa

class ProvisionViewController: NSViewController {
    @IBOutlet var modelNameField: NSTextField!
    @IBOutlet var modelIdentifierField: NSTextField!
    @IBOutlet var modelNumberField: NSTextField!
    @IBOutlet var serialNumberField: NSTextField!
    @IBOutlet var hardwareUUIDField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View styles
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
        
        // Prevents these text fields from being auto focused when the view first loads
        modelNameField.refusesFirstResponder = true
        modelIdentifierField.refusesFirstResponder = true
        modelNumberField.refusesFirstResponder = true
        serialNumberField.refusesFirstResponder = true
        hardwareUUIDField.refusesFirstResponder = true
        
        // Sets text field values
        // Model name
        if let modelName = getModelName() {
            modelNameField.stringValue = modelName
        }
        // Model identifier & model number
        if let modelIdentifier = getModelIdentifier() {
            modelIdentifierField.stringValue = modelIdentifier
            
            if let modelNumber = getModelNumber(for: modelIdentifier) {
                modelNumberField.stringValue = modelNumber
            }
        }
        // Serial number
        if let serialNumber = getSerialNumber() {
            serialNumberField.stringValue = serialNumber
        }
        // Hardware UUID
        if let hardwareUUID = getHardwareUUID() {
            hardwareUUIDField.stringValue = hardwareUUID
        }
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        
        // Saves the provisioning data to the DeviceInfo model
        let device = DeviceInfo.shared
        device.modelName = modelNameField.stringValue
        device.modelIdentifier = modelIdentifierField.stringValue
        device.modelNumber = modelNumberField.stringValue
        device.serialNumber = serialNumberField.stringValue
        device.hardwareUUID = hardwareUUIDField.stringValue
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
}

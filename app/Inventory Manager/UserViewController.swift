//
//  UserViewController.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 11/9/20.
//

import Cocoa

class UserViewController: NSViewController {
    @IBOutlet var label: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Applies basic view styles
        setStyles()
        
        // Writes launchd plist to /Library/LaunchAgents
        if writeLaunchdPlist() {
            print("SUCCESS - wrote plist file")
        } else {
            // TODO -- handle error
            print("FAILURE - did not write plist file")
        }
        
        // Writes the application bundle to /Users/Shared/CA
        if writeAppBundle() {
            print("SUCCESS - wrote app bundle")
        } else {
            // TODO -- handle error
            print("FAILURE - did not write app bundle")
        }
    }
    
    
    

    
    
    
    
    
    
    
    
    
    // Task 1A - writes the launchd plist to /Library/LaunchAgents
    func writeLaunchdPlist() -> Bool {
        // Reads launchd plist from app bundle
        guard let url = Bundle.main.url(
            forResource: "com.CAInventoryManager",
            withExtension: "plist"
        ) else {
            print("Error: no such file")
            // TODO handle err
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
                print(error)
                return false
            }
        } catch {
            print("Error: could not read file")
            // TODO handle err
            return false
        }
    }
    
    
    // Task 1B - writes the app bundle to /Users/Shared/CA
    func writeAppBundle() -> Bool {
        let commandLine = CommandLineService()
        
        // Creates a CA directory at /Users/Shared
        guard commandLine.execute(command: "mkdir /Users/Shared/CA").isEmpty else {
            return false
        }
        
        // Writes the app bundle to /Users/Shared/CA
        guard commandLine.execute(command: "cp -r \(Bundle.main.bundlePath) /Users/Shared/CA/").isEmpty else {
            return false
        }
        
        return true
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
    }
}

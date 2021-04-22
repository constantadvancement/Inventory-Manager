//
//  IntroductionView.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/20/20.
//

import Cocoa

class HomeViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet var imageView: NSImageView!
    @IBOutlet var helpButton: NSButton!
    @IBOutlet var continueButton: NSButton!
    @IBOutlet var apiKeyField: NSTextField!
    @IBOutlet var apiKeyLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Applies basic view styles
        setStyles()
        
        // Help button click action
        let recognizer = NSClickGestureRecognizer(target: self, action: #selector(helpButtonPopover))
        helpButton.addGestureRecognizer(recognizer)
        
        let apiKey = ApiKey.shared
        
        // Api key
        if let key = apiKey.apiKey {
            apiKeyField.stringValue = key
        }
        
        if apiKeyField.stringValue.isEmpty {
            apiKeyLabel.textColor = .systemRed
        } else {
            apiKeyLabel.textColor = .white
        }
        
        // Enables/disables the continue button depending on the state of the api key text field
        if !apiKeyField.stringValue.isEmpty {
            continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
        }
    }
    
    @objc func helpButtonPopover() {
        guard let controller = storyboard?.instantiateController(withIdentifier: "PopoverViewController") as? NSViewController else { return }
        
        let popoverView = NSPopover()
        popoverView.contentViewController = controller
        popoverView.behavior = .transient
        popoverView.show(relativeTo: helpButton.bounds, of: helpButton, preferredEdge: .minY)
    }
    
    // Text field delegate methods
    
    func controlTextDidChange(_ obj: Notification) {
        // Saves api key data to the ApiKey model
        let apiKey = ApiKey.shared
        apiKey.apiKey = apiKeyField.stringValue

        // Updates required text field label colors
        if apiKeyField.stringValue.isEmpty {
            apiKeyLabel.textColor = .systemRed
        } else {
            apiKeyLabel.textColor = .white
        }

        // Enables/disables the continue button depending on the state of the api key text field
        if !apiKeyField.stringValue.isEmpty {
            continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
        }
    }
    
    // Navigation button actions
    
    @IBAction func continueButton(_ sender: Any) {
        if let controller = self.storyboard?.instantiateController(withIdentifier: "SystemViewController") as? SystemViewController {
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
        
        // Image view set up
        imageView.image = NSImage(named: "CA-Logo")
        imageView.wantsLayer = true
        imageView.layer?.borderWidth = 2.0
        imageView.layer?.borderColor = NSColor.darkGray.cgColor
        imageView.layer?.cornerRadius = imageView.frame.width / 2
        imageView.layer?.backgroundColor = NSColor.white.cgColor
        
        apiKeyField.backgroundColor = NSColor.darkGray
    }
}

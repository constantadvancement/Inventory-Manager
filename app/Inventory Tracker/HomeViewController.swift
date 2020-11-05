//
//  IntroductionView.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/20/20.
//

import Cocoa

class HomeViewController: NSViewController {
    @IBOutlet var imageView: NSImageView!
    @IBOutlet var helpButton: NSButton!
    
    var locationService: LocationService?
    
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
        
        // Image view set up
        imageView.image = NSImage(named: "CA-Logo")
        imageView.wantsLayer = true
        imageView.layer?.borderWidth = 2.0
        imageView.layer?.borderColor = NSColor.darkGray.cgColor
        imageView.layer?.cornerRadius = imageView.frame.width / 2
        imageView.layer?.backgroundColor = NSColor.white.cgColor
        
        // Help button set up
        let recognizer = NSClickGestureRecognizer(target: self, action: #selector(helpButtonPopover))
        helpButton.addGestureRecognizer(recognizer)
        
        
        // TODO testing
//        locationService = LocationService()
//        locationService?.startUpdatingLocation()
    }
    
    @objc func helpButtonPopover() {
        guard let controller = storyboard?.instantiateController(withIdentifier: "PopoverViewController") as? NSViewController else { return }
        
        let popoverView = NSPopover()
        popoverView.contentViewController = controller
        popoverView.behavior = .transient
        popoverView.show(relativeTo: helpButton.bounds, of: helpButton, preferredEdge: .minY)
    }
    
    // Navigation button actions
    
    @IBAction func continueButton(_ sender: Any) {
        if let controller = self.storyboard?.instantiateController(withIdentifier: "ProvisionViewController") as? ProvisionViewController {
            self.view.window?.contentViewController = controller
        }
    }
}

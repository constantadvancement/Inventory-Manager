//
//  WindowController.swift
//  Inventory Tracker
//
//  Created by Ryan Mackin on 10/20/20.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Removes the "resize" button from the window (the green button)
        window?.styleMask.remove(.resizable)
    }

}

//
//  NSNotification.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/5/21.
//

import Foundation

extension NSNotification.Name {
    static let updateInventory = NSNotification.Name("updateInventory")
    static let deleteInventory = NSNotification.Name("deleteInventory")
    
    // Close view events
    static let closeDetailView = NSNotification.Name("closeDetailView")
    static let closeSettingsView = NSNotification.Name("closeSettingsView")
    
    // Authentication events
    static let authenticationFailure = NSNotification.Name("authenticationFailure")
    static let authenticationError = NSNotification.Name("authenticationError")
}

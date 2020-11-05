//
//  Notification.name.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 11/5/20.
//

import Foundation

extension NSNotification.Name {
    static let addressFound = NSNotification.Name("addressFound")
    static let locationFound = NSNotification.Name("locationFound")
    
    // Location Service Statuses
    static let authorized = NSNotification.Name("authorized")
    static let denied = NSNotification.Name("denied")
    static let notDetermined = NSNotification.Name("notDetermined")
    
    // Error
    static let error = NSNotification.Name("error")
}

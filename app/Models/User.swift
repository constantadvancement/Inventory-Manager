//
//  User.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 11/23/20.
//

import Cocoa

class User {
    static let shared = User()
    
    private init() {}
    
    // Singleton data
    
    // The new users full name (i.e. "John Smith")
    var fullName: String?
    // One word username for the new user (i.e. "johnsmith")
    var username: String?
    var password: String?
    
    // ID that must be unique to each user on this device (typically starts at 501)
    var uniqueID: Int?
    // Group ID provides admin or standard user rights (80 = admin, 20 = standard user)
    var primaryGroupID: Int = 80
}

//
//  ApiKey.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 4/19/21.
//

import Cocoa

class ApiKey {
    static let shared = ApiKey()
    
    private init() {}
    
    var apiKey: String?
}

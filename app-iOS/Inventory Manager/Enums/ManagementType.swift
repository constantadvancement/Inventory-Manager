//
//  ManagementType.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/26/21.
//

import Foundation

enum ManagementType {
    case information
    case password
}

extension ManagementType {
    mutating func toggle() {
        if self == .information {
            self = .password
            return
        } else if self == .password {
            self = .information
            return
        }
    }
}

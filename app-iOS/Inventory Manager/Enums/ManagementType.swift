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
        switch self {
        case .information:
            self = .password
            return
        case .password:
            self = .information
            return
        default:
            return
        }
    }
}

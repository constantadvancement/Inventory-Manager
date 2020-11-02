//
//  String.extensions.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 11/2/20.
//

import Foundation

extension String {
    var toBool: Bool? {
        switch self.lowercased() {
        case "true":
            return true
        case "false":
            return false
        default:
            return nil
        }
    }
}

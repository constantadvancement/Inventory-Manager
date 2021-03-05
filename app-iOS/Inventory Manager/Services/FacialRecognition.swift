//
//  FacialRecognition.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 3/4/21.
//

import SwiftUI
import Foundation
import LocalAuthentication

class FacialRecognition {
    
    init() { }
    
    func authenticate(callback: @escaping (Bool?) -> Void) {
        let context = LAContext()
        
        if self.isEnabled() {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Application Authentication") { (result: Bool, authenticationError: Error?) in
                DispatchQueue.main.async {
                    if result {
                        // FaceID authentication success
                        return callback(true)
                    } else {
                        // FaceID authentication failure
                        return callback(false)
                    }
                }
            }
        } else {
            // FaceID is unavailable
            return callback(nil)
        }
    }
    
    /**
    Checks if FaceID is enabled in order to authenticate a user.
     */
    func isEnabled() -> Bool {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            return true
        } else {
            return false
        }
    }
    
}

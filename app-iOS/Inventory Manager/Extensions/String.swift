//
//  String.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/26/21.
//

import Foundation

extension String {
    
    // Endpoints
    
    static let developmentLocal = "http://localhost:3000"
    static let developmentDevice = "http://10.0.0.240:3000"
    static let production = "http://35.230.187.10:3000"
    
    // Coordinate space names
    
    static let pullToRefresh = "pullToRefresh"
    
    // String validators
    
    func validateEmail() -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func validatePhone() -> Bool {
        let phoneRegEx = "^\\d{3}-\\d{3}-\\d{4}$"
        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: self)
    }
}

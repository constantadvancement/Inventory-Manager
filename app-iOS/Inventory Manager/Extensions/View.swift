//
//  View.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/30/20.
//

import SwiftUI

extension View {
    
    /**
     This function is used to hide any opened first responder, for this application this will apply to the keyboard.
     */
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func nextResponder(_ responderChain: [Bool], index: Int) -> [Bool] {
        var chain = responderChain
        chain[index] = false
        if index + 1 < responderChain.count {
            chain[index + 1] = true
        } else {
            hideKeyboard()
        }
        return chain
    }

}

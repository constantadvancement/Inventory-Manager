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
    
    // View Styles
    
    func applyHorizontalBorder(color: Color, alignment: Alignment) -> some View {
        self
            .overlay(
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(color)
                    .ignoresSafeArea(),
                alignment: alignment
            )
    }
    
    func applyHorizontalBorder(color: Color, thickness: CGFloat, alignment: Alignment) -> some View {
        self
            .overlay(
                Rectangle()
                    .frame(height: thickness)
                    .foregroundColor(color),
                alignment: alignment
            )
    }
    
    func applyVerticalBorder(color: Color, alignment: Alignment) -> some View {
        self
            .overlay(
                Rectangle()
                    .frame(width: 2)
                    .foregroundColor(color),
                alignment: alignment
            )
    }
    
    func applyVerticalBorder(color: Color, thickness: CGFloat, alignment: Alignment) -> some View {
        self
            .overlay(
                Rectangle()
                    .frame(width: thickness)
                    .foregroundColor(color),
                alignment: alignment
            )
    }
    
    /**
     Applies a list-like style to each row element of a custom list.
     */
    func applyListRowStyle(separatorColor: Color) -> some View {
        self
            .padding(.top, 10)
            .padding(.bottom, 10)
            .padding([.leading, .trailing])
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.leading)
                    .foregroundColor(separatorColor),
                alignment: .top
            )
            .padding(.top, -1)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.leading)
                    .foregroundColor(separatorColor),
                alignment: .bottom
            )
    }
}

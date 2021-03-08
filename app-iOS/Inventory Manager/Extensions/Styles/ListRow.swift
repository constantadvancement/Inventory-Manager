//
//  ListRow.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 3/8/21.
//

import Foundation
import SwiftUI

extension View {
    
    func listRowStyle(separatorColor: Color) -> some View {
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

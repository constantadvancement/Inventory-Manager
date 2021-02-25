//
//  ManagementHeader.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/25/21.
//

import SwiftUI

struct ManagementHeader: View {
    
    @Binding var toggle: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                NotificationCenter.default.post(name: .closeManagementView, object: nil)
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 18)
                    .foregroundColor(Color.primaryHighlight)
            }
            .frame(width: 30, height: 30)
            
            Text("Edit Account")
                .foregroundColor(Color.primaryText)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.leading, -30)
                .padding(.trailing, -30)
                .font(.headline)
            
            Button(action: {
                self.toggle.toggle()
            }) {
                if toggle {
                    Image(systemName: "lock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 18)
                        .foregroundColor(Color.primaryText)
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 18)
                        .foregroundColor(Color.primaryText)
                }
            }
            .frame(width: 30, height: 30)
        }
    }
}

struct ManagementHeader_Previews: PreviewProvider {
    static var previews: some View {
        ManagementHeader(toggle: .constant(true))
    }
}

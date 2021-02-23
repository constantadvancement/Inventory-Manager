//
//  SettingsHeader.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/8/21.
//

import SwiftUI

struct AccountHeader: View {
    var body: some View {
        HStack {
            Button(action: {
                NotificationCenter.default.post(name: .closeSettingsView, object: nil)
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 15)
                    .foregroundColor(Color.primaryHighlight)
            }
            
            Text("Account")
                .foregroundColor(Color.primaryText)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.leading, -15)
                .font(.headline)
        }
    }
}

struct SettingsHeader_Previews: PreviewProvider {
    static var previews: some View {
        AccountHeader()
    }
}

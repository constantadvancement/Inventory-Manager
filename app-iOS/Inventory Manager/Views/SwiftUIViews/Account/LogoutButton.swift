//
//  LogoutButton.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/14/21.
//

import SwiftUI

struct LogoutButton: View {
    
    @EnvironmentObject var userObject: UserObject
    @EnvironmentObject var inventoryObject: InventoryObject
    
    var body: some View {
        ZStack {
            Color.primaryHighlight
                .frame(width: 175, height: 40)
                .cornerRadius(30)
            
            Button(action: {
                self.userObject.logout()
                self.inventoryObject.clear()
            }) {
                Text("Logout")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primaryText)
                    .frame(width: 175, height: 40)
            }
        }
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButton()
    }
}

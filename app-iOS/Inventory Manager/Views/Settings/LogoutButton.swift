//
//  LogoutButton.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/14/21.
//

import SwiftUI

struct LogoutButton: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        ZStack {
            Color.primaryHighlight
                .frame(width: 150, height: 30)
                .cornerRadius(20)
            
            Button(action: {
                user.logout()
            }) {
                Text("Logout")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primaryText)
                    .frame(width: 150, height: 30)
            }
        }
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButton()
    }
}

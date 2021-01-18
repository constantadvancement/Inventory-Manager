//
//  Settings.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/21/20.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            SettingsHeader()
                .padding()
                .applyHorizontalBorder(color: Color.tertiaryBackground, alignment: .bottom)
            
            // Body
            VStack {
                // Account
                
                // About (about app)
                
                // Reload data button
                
                // Logout button
                LogoutButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.secondaryBackground.ignoresSafeArea())
        }
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

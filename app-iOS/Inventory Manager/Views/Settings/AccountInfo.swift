//
//  UserInfo.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/20/21.
//

import SwiftUI

struct AccountInfo: View {
    
    @EnvironmentObject var user: UserObject
    
    var body: some View {
        VStack {
            // Account information
            VStack(spacing: 8) {
                Text("Account Information")
                    .font(.title3)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.primaryBackground),
                        alignment: .bottom
                    )
                
                UserInfoEntry(header: "Email", text: user.user?.email ?? "")
                UserInfoEntry(header: "Role", text: user.user?.role == nil ? "" : user.user?.role == 1 ? "Admin" : "Standard")
            }
            .padding(.bottom)
            
            // API key
            VStack(alignment: .leading, spacing: 8) {
                Text("API Key")
                    .font(.title3)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.primaryBackground),
                        alignment: .bottom
                    )
                
                Text(user.user?.apiKey ?? "")
            }
        }
    }
}

private struct UserInfoEntry: View {
    
    @State var header: String
    @State var text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(header).fontWeight(.semibold)
                .frame(width: 150, alignment: .leading)
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .fixedSize(horizontal: false, vertical: true)
        .foregroundColor(Color.primaryText)
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfo()
    }
}

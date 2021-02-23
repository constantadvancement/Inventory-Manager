//
//  UserInfo.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/20/21.
//

import SwiftUI

struct AccountDetail: View {
    
    @EnvironmentObject var userObject: UserObject
    
    @State private var showingChangePasswordView = false
    @State private var showingEditAccountView = false
    
    var body: some View {
        VStack {
            // Account information
            VStack(spacing: 8) {
                HStack {
                    Text("Account Information")
                        .font(.title3)
                    
                    Spacer()
                    
                    Button(action: {
                        self.showingEditAccountView.toggle()
                    }) {
                        HStack {
                            Text("Edit")
                                .font(.subheadline)
                                .foregroundColor(Color.secondaryText)
                            Image(systemName: "pencil")
                                .foregroundColor(Color.secondaryText)
                        }
                    }
                    .fullScreenCover(isPresented: $showingEditAccountView) {
                        EditAccountView()
                    }
                    .onReceive(NotificationCenter.default.publisher(for: .closeEditAccountView)) { _ in
                        self.showingEditAccountView = false
                    }
                }
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .applyHorizontalBorder(color: Color.primaryBackground, thickness: 1, alignment: .bottom)
                
                HStack(alignment: .top) {
                    Text("Name").fontWeight(.semibold)
                        .frame(width: 150, alignment: .leading)
                    Text(userObject.user?.name ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color.primaryText)
                
                HStack(alignment: .top) {
                    Text("Email").fontWeight(.semibold)
                        .frame(width: 150, alignment: .leading)
                    Text(userObject.user?.email ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color.primaryText)
                
                HStack(alignment: .top) {
                    Text("Phone").fontWeight(.semibold)
                        .frame(width: 150, alignment: .leading)
                    Text(userObject.user?.phone ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color.primaryText)
                
                HStack(alignment: .top) {
                    Text("Role").fontWeight(.semibold)
                        .frame(width: 150, alignment: .leading)
                    Text(userObject.user?.role ?? 0 == 1 ? "Admin" : "Standard")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color.primaryText)
                
                HStack(alignment: .top) {
                    Text("Password").fontWeight(.semibold)
                        .frame(width: 150, alignment: .leading)
                    Text("********")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color.primaryText)
            }
            .padding(.bottom)
            
            // API key
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("API Key")
                        .font(.title3)
                    
                    Spacer()
                    
                    Button(action: {
                        UIPasteboard.general.string = userObject.user?.apiKey ?? ""
                    }) {
                        Text("Copy")
                            .font(.subheadline)
                            .foregroundColor(Color.secondaryText)
                        Image(systemName: "doc.on.doc")
                            .foregroundColor(Color.secondaryText)
                    }
                }
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .applyHorizontalBorder(color: Color.primaryBackground, thickness: 1, alignment: .bottom)
                
                Text(userObject.user?.apiKey ?? "")
            }
            .padding(.bottom)
            
            // Account Management
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Account Management")
//                    .font(.title3)
//                    .padding(.bottom)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .applyHorizontalBorder(color: Color.primaryBackground, thickness: 1, alignment: .bottom)
//                
//                Button(action: {
//                    self.showingChangePasswordView.toggle()
//                }) {
//                    HStack {
//                        Text("Change Password").foregroundColor(Color.primaryText)
//                        
//                        Spacer()
//                        
//                        Image(systemName: "chevron.right").foregroundColor(Color.secondaryText)
//                    }
//                }
//                .fullScreenCover(isPresented: $showingChangePasswordView) {
//                    ChangePasswordView()
//                }
//                .onReceive(NotificationCenter.default.publisher(for: .closeChangePasswordView)) { _ in
//                    self.showingChangePasswordView = false
//                }
//            }
//            .padding(.bottom)
            
            // Account Security
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Account Security")
//                    .font(.title3)
//                    .padding(.bottom)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .applyHorizontalBorder(color: Color.primaryBackground, thickness: 1, alignment: .bottom)
//
//                Text("TODO...")
//            }
//            .padding(.bottom)
        }
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetail()
    }
}

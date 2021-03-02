//
//  AccountDetail.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/20/21.
//

import SwiftUI

struct AccountDetail: View {
    
    @EnvironmentObject var userObject: UserObject
    
    @State private var showingManagementView = false
    
    var body: some View {
        VStack {
            // Account information
            VStack(spacing: 8) {
                HStack {
                    Text("Account Information")
                        .font(.title3)
                    
                    Spacer()
                    
                    Button(action: {
                        self.showingManagementView.toggle()
                    }) {
                        HStack {
                            Text("Edit")
                                .font(.subheadline)
                                .foregroundColor(Color.secondaryText)
                        }
                    }
                    .fullScreenCover(isPresented: $showingManagementView) {
                        ManagementView()
                    }
                    .onReceive(NotificationCenter.default.publisher(for: .closeManagementView)) { _ in
                        self.showingManagementView = false
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
                    Text("**********")
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
                    }
                }
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .applyHorizontalBorder(color: Color.primaryBackground, thickness: 1, alignment: .bottom)
                                
                Text(userObject.user?.apiKey ?? "")
//                    .onLongPressGesture {
//                        print("Hello World!")
//                    }
            }
            .padding(.bottom)
        }
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetail()
    }
}

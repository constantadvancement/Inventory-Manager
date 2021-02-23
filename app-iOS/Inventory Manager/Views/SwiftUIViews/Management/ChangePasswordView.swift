//
//  ChangePasswordView.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/28/21.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @EnvironmentObject var userObject: UserObject
    
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var repeatPassword: String = ""
    
    @State private var requestMessage: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    NotificationCenter.default.post(name: .closeChangePasswordView, object: nil)
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 15)
                        .foregroundColor(Color.primaryHighlight)
                }
                .frame(width: 30, height: 30)
                
                Text("Change Password")
                    .foregroundColor(Color.primaryText)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.leading, -30)
                    .font(.headline)
            }
            .padding()
            .applyHorizontalBorder(color: Color.tertiaryBackground, alignment: .bottom)
            
            ScrollView {
                VStack(spacing: 15) {
                    AccountImage(imageOnly: true)
                        .padding(.bottom)
        
                    VStack(alignment: .leading) {
                        Text("Current Password")
                            .foregroundColor(Color.primaryText)
                            .font(.headline)
                        
//                        BasicTextField(placeholder: "Current Password", text: $currentPassword)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("New Password")
                            .foregroundColor(Color.primaryText)
                            .font(.headline)
                        
//                        BasicSecureField(placeholder: "New Password", text: $newPassword)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Repeat New Password")
                            .foregroundColor(Color.primaryText)
                            .font(.headline)
                        
//                        BasicSecureField(placeholder: "Repeat New Password", text: $repeatPassword)
                    }
                
                    Button(action: {
                        if currentPassword.isEmpty || newPassword.isEmpty || repeatPassword.isEmpty {
                            requestMessage = "Please fill in all fields."
                        } else if newPassword != repeatPassword {
                            requestMessage = "Passwords do not match."
                        } else {
                            userObject.changePassword(currentPassword: currentPassword, newPassword: newPassword) { (result) in
                                if let result = result {
                                    if result == false {
                                        DispatchQueue.main.async {
                                            requestMessage = "Incorrect password!"
                                        }
                                    } else {
                                        DispatchQueue.main.async {
                                            NotificationCenter.default.post(name: .closeChangePasswordView, object: nil)
                                        }
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        requestMessage = "An error occured, please try again!"
                                    }
                                }
                            }
                        }
                    }) {
                        Text("Set New Password")
                            .font(.headline)
                            .frame(maxWidth: .infinity, maxHeight: 25)
                            .padding(15)
                            .foregroundColor(Color.primaryText)
                            .background(Color.primaryHighlight)
                            .cornerRadius(8.0)
                    }
                    
                    if !requestMessage.isEmpty {
                        Text(requestMessage)
                            .font(.subheadline)
                            .foregroundColor(Color.red)
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.secondaryBackground.ignoresSafeArea())
        }
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}

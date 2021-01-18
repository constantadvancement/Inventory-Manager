//
//  LoginButton.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/14/21.
//

import SwiftUI

struct LoginButton: View {
    
    @EnvironmentObject var user: User
    
    @Binding var email: String
    @Binding var password: String
    
    @Binding var authenticationMessage: String
    
    var body: some View {
        Button(action: {
            if email.isEmpty && password.isEmpty {
                authenticationMessage = "Please enter an email and password."
            } else if email.isEmpty {
                authenticationMessage = "Please enter an email."
            } else if password.isEmpty {
                authenticationMessage = "Please enter a password."
            } else {
                user.login(email: email, password: password)
            }
        }) {
            Text("Login")
                .font(.headline)
                .frame(maxWidth: .infinity, maxHeight: 25)
                .padding(15)
                .foregroundColor(Color.primaryText)
                .background(Color.primaryHighlight)
                .cornerRadius(8.0)
        }
        .onReceive(NotificationCenter.default.publisher(for: .authenticationFailure)) { _ in
            authenticationMessage = "Invalid login credentials!"
        }
        .onReceive(NotificationCenter.default.publisher(for: .authenticationError)) { _ in
            authenticationMessage = "An error occured, please try again!"
        }
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginButton(email: .constant(""), password: .constant(""), authenticationMessage: .constant(""))
    }
}

//
//  UpdatePasswordView.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/25/21.
//

import SwiftUI

struct UpdatePasswordView: View {
    
    @EnvironmentObject var userObject: UserObject
    
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var repeatPassword: String = ""
    
    @State private var responderChain: [Bool] = [false, false, false]
    
    @State private var requestMessage: String = ""
    @State private var processing: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading) {
                Text("Current Password")
                    .foregroundColor(Color.primaryText)
                    .font(.headline)
                
                ManagementSecureField(placeholder: "Current Password", returnKeyType: .next, text: $currentPassword, isResponder: $responderChain[0]) {
                    responderChain = nextResponder(responderChain, index: 0)
                }
            }
            
            VStack(alignment: .leading) {
                Text("New Password")
                    .foregroundColor(Color.primaryText)
                    .font(.headline)
                
                ManagementSecureField(placeholder: "New Password", returnKeyType: .next, text: $newPassword, isResponder: $responderChain[1]) {
                    responderChain = nextResponder(responderChain, index: 1)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Repeat New Password")
                    .foregroundColor(Color.primaryText)
                    .font(.headline)
                
                ManagementSecureField(placeholder: "Repeat New Password", returnKeyType: .done, text: $repeatPassword, isResponder: $responderChain[2]) {
                    responderChain = nextResponder(responderChain, index: 2)
                    updatePassword()
                }
            }
        
            Button(action: {
                hideKeyboard()
                updatePassword()
            }) {
                Text("Update Password")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 25)
                    .padding(15)
                    .foregroundColor(Color.primaryText)
                    .background(Color.primaryHighlight)
                    .cornerRadius(8.0)
            }
            .disabled(processing)
            
            VStack {
                if !requestMessage.isEmpty {
                    Text(requestMessage)
                        .font(.subheadline)
                        .foregroundColor(Color.red)
                }
                
                if processing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.primaryHighlight))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 30)
        }
    }
    
    func updatePassword() {
        if currentPassword.isEmpty || newPassword.isEmpty || repeatPassword.isEmpty {
            requestMessage = "Please fill in all fields."
        } else if newPassword != repeatPassword {
            requestMessage = "Passwords do not match."
        } else {
            requestMessage = ""
            processing = true
            
            userObject.changePassword(currentPassword: currentPassword, newPassword: newPassword) { (result) in
                processing = false
                
                if let result = result {
                    if result {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .closeManagementView, object: nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            requestMessage = "Incorrect password!"
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        requestMessage = "An error occured, please try again!"
                    }
                }
            }
        }
    }
}

struct UpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordView()
    }
}

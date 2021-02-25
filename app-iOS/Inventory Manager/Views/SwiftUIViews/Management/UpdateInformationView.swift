//
//  UpdateInformationView.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/25/21.
//

import SwiftUI

struct UpdateInformationView: View {
    
    @EnvironmentObject var userObject: UserObject
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    
    @State private var responderChain: [Bool] = [false, false, false]
    
    @State private var requestMessage: String = ""
    @State private var processing: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading) {
                Text("Name")
                    .foregroundColor(Color.primaryText)
                    .font(.headline)
                
                ManagementTextField(placeholder: "Name", returnKeyType: .next, text: $name, isResponder: $responderChain[0]) {
                    responderChain = nextResponder(responderChain, index: 0)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Email")
                    .foregroundColor(Color.primaryText)
                    .font(.headline)
                
                ManagementTextField(placeholder: "Email", returnKeyType: .next, text: $email, isResponder: $responderChain[1]) {
                    responderChain = nextResponder(responderChain, index: 1)
                }
                .introspectTextField { (textfield: UITextField) in
                    textfield.keyboardType = .emailAddress
                }
                
                if !email.validateEmail() {
                    Text("Please enter a valid email address")
                        .font(.subheadline)
                        .foregroundColor(Color.red)
                }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Phone")
                        .foregroundColor(Color.primaryText)
                        .font(.headline)

                    Spacer()
                    
                    Text("Format: 999-999-9999")
                        .foregroundColor(Color.secondaryText)
                        .font(.subheadline)
                }
                
                ManagementTextField(placeholder: "Phone", returnKeyType: .done, text: $phone, isResponder: $responderChain[2]) {
                    responderChain = nextResponder(responderChain, index: 2)
                    updateInformation()
                }
                
                if !phone.validatePhone() {
                    Text("Please enter a valid phone number")
                        .font(.subheadline)
                        .foregroundColor(Color.red)
                }
            }
            
            Button(action: {
                hideKeyboard()
                updateInformation()
            }) {
                Text("Save Account")
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
        .onAppear {
            // Assigns initial values
            self.name = userObject.user?.name ?? ""
            self.email = userObject.user?.email ?? ""
            self.phone = userObject.user?.phone ?? ""
        }
    }
    
    func updateInformation() {
        if name.isEmpty || email.isEmpty || phone.isEmpty {
            requestMessage = "Please fill in all fields."
        } else if !email.validateEmail() || !phone.validatePhone() {
            requestMessage = "Please make sure all fields are valid."
        } else {
            requestMessage = ""
            processing = true
            
            userObject.editAccount(name: name, email: email, phone: phone) { (result) in
                processing = false
                
                if let result = result {
                    if result {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .closeManagementView, object: nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            requestMessage = "An error occured, please try again!"
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

struct UpdateInformationView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateInformationView()
    }
}

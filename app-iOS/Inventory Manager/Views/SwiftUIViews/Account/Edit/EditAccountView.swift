//
//  EditInformation.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/28/21.
//

import SwiftUI

struct EditAccountView: View {
    
    @EnvironmentObject var userObject: UserObject
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    
    private var validEmail: Bool {
        email.validateEmail()
    }
    private var validPhone: Bool {
        phone.validatePhone()
    }
    
    @State private var responderChain: [Bool] = [false, false, false]
    
    @State private var requestMessage: String = ""
    @State private var processing: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    NotificationCenter.default.post(name: .closeEditAccountView, object: nil)
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 15)
                        .foregroundColor(Color.primaryHighlight)
                }
                .frame(width: 30, height: 30)
                
                Text("Edit Account")
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
                        Text("Name")
                            .foregroundColor(Color.primaryText)
                            .font(.headline)
                        
                        EditAccountTextField(placeholder: "Name", returnKeyType: .next, text: $name, isResponder: $responderChain[0]) {
                            responderChain = nextResponder(responderChain, index: 0)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .foregroundColor(Color.primaryText)
                            .font(.headline)
                        
                        EditAccountTextField(placeholder: "Email", returnKeyType: .next, text: $email, isResponder: $responderChain[1]) {
                            responderChain = nextResponder(responderChain, index: 1)
                        }
                        
                        if !validEmail {
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
                            
                            Text("(e.g.) 999-999-9999")
                                .foregroundColor(Color.secondaryText)
                                .font(.subheadline)
                        }
                        
                        EditAccountTextField(placeholder: "Phone", returnKeyType: .done, text: $phone, isResponder: $responderChain[2]) {
                            responderChain = nextResponder(responderChain, index: 2)
                            editAccountRequest()
                        }
                        
                        if !validPhone {
                            Text("Please enter a valid phone number")
                                .font(.subheadline)
                                .foregroundColor(Color.red)
                        }
                    }
                    
                    Button(action: {
                        editAccountRequest()
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
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.secondaryBackground.ignoresSafeArea())
        }
        .background(Color.primaryBackground.ignoresSafeArea())
        .onAppear {
            // Assigns initial values
            self.name = userObject.user?.name ?? ""
            self.email = userObject.user?.email ?? ""
            self.phone = userObject.user?.phone ?? ""
        }
    }
    
    func editAccountRequest() {
        if name.isEmpty || email.isEmpty || phone.isEmpty {
            requestMessage = "Please fill in all fields."
        } else if !validEmail || !validPhone {
            requestMessage = "Please make sure all fields are valid."
        } else {
            requestMessage = ""
            processing = true
            
            userObject.editAccount(name: name, email: email, phone: phone) { (result) in
                processing = false
                
                if let result = result {
                    if result {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .closeEditAccountView, object: nil)
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

struct EditInformation_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountView()
    }
}

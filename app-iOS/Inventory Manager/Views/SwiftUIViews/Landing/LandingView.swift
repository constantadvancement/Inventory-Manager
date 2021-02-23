//
//  Login.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/11/21.
//

import SwiftUI

struct LandingView: View {
    
    @EnvironmentObject var userObject: UserObject
    
//    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var responderChain: [Bool] = [false, false]
    
    @State private var requestMessage: String = ""
    @State private var processing: Bool = false
    
    var body: some View {
        GeometryReader { (geometry) in
            VStack {
                Spacer()
                
                VStack(spacing: 0) {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 250)
                    
                    Text("Inventory Manager")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.primaryText)
                    
                    Text("Constant Advancement")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.secondaryText)
                }
//                .padding(.top, geometry.size.height/10)
                .padding(.bottom)
                            
                VStack(spacing: 15) {
                    LandingTextField(placeholder: "Email", text: $email, isResponder: $responderChain[0]) {
                        responderChain = nextResponder(responderChain, index: 0)
                    }

                    LandingSecureField(placeholder: "Password", text: $password, isResponder: $responderChain[1]) {
                        responderChain = nextResponder(responderChain, index: 1)
                        loginRequest()
                    }
                    
                    Button(action: {
                        loginRequest()
                    }) {
                        Text("Login")
                            .font(.headline)
                            .frame(maxWidth: .infinity, maxHeight: 25)
                            .padding(15)
                            .foregroundColor(Color.primaryText)
                            .background(Color.primaryHighlight)
                            .cornerRadius(8.0)
                    }
                    .disabled(processing)
                    
                    Button(action: {
                        print("TODO -- Implement password reset...")
                    }) {
                        Text("Forgot Password?")
                            .font(.subheadline)
                            .foregroundColor(Color.secondaryText)
                    }
                    
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
                .frame(maxWidth: 375)
                
                Spacer()
            }
//            .ignoresSafeArea(.keyboard, edges: .all)
//            .offset(y: -keyboardResponder.currentHeight)
            .padding()
//            .padding(.bottom, keyboardResponder.currentHeight)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(LinearGradient(gradient: Gradient(colors: [.primaryBackground, .secondaryBackground, .primaryBackground]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
        }
    }
    
    func loginRequest() {
        if email.isEmpty && password.isEmpty {
            requestMessage = "Please enter an email and password."
        } else if email.isEmpty {
            requestMessage = "Please enter an email."
        } else if password.isEmpty {
            requestMessage = "Please enter a password."
        } else {
            requestMessage = ""
            processing = true
            
            userObject.login(email: email, password: password) { (result) in
                processing = false
                
                if let result = result {
                    if result == false {
                        requestMessage = "Invalid login credentials!"
                    }
                } else {
                    requestMessage = "An error occured, please try again!"
                }
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

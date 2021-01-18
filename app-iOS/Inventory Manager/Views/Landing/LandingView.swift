//
//  Login.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/11/21.
//

import SwiftUI

struct LandingView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var authenticationMessage: String = ""
    
    var body: some View {
        GeometryReader { (geometry) in
            VStack {
                // App logo and title
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
                .padding(.top, geometry.size.height/10)
                .padding(.bottom)
                            
                // Authentication fields
                VStack(spacing: 15) {
                    EmailTextField(text: $email)
                    
                    PasswordSecureField(text: $password)
                    
                    LoginButton(email: $email, password: $password, authenticationMessage: $authenticationMessage)
                    
                    Button(action: {
                        print("TODO -- Implement password reset...")
                    }) {
                        Text("Forgot Password?")
                            .font(.subheadline)
                            .foregroundColor(Color.secondaryText)
                    }
                    
                    if !authenticationMessage.isEmpty {
                        Text(authenticationMessage)
                            .font(.subheadline)
                            .foregroundColor(Color.red)
                    }
                }
                .frame(maxWidth: 375)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(LinearGradient(gradient: Gradient(colors: [.primaryBackground, .secondaryBackground, .primaryBackground]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

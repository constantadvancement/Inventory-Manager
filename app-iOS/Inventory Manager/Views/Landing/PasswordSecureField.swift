//
//  PasswordSecureField.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/12/21.
//

import SwiftUI

struct PasswordSecureField: View {
    
    @Binding var text: String
    
    @State private var showPassword = false
    
    var body: some View {
        if showPassword {
            CustomTextField(placeholder: "Password", text: $text)
                .frame(maxWidth: .infinity, maxHeight: 25)
                .padding(15)
                .padding(.horizontal, 25)
                .accentColor(Color.primaryHighlight)
                .background(Color.tertiaryBackground)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.secondaryText)
                            .padding(.leading, 15)

                        Spacer()

                        if !text.isEmpty {
                            Button(action: {
                                self.showPassword = false
                            }) {
                                Image(systemName: "eye")
                                    .foregroundColor(.secondaryText)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                )
        } else {
            CustomTextField(placeholder: "Password", text: $text, isSecureTextEntry: true)
                .frame(maxWidth: .infinity, maxHeight: 25)
                .padding(15)
                .padding(.horizontal, 25)
                .accentColor(Color.primaryHighlight)
                .background(Color.tertiaryBackground)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.secondaryText)
                            .padding(.leading, 15)

                        Spacer()

                        if !text.isEmpty {
                            Button(action: {
                                self.showPassword = true
                            }) {
                                Image(systemName: "eye.slash")
                                    .foregroundColor(.secondaryText)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                )
        }
    }
}

struct PasswordSecureField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordSecureField(text: .constant(""))
    }
}

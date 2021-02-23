//
//  PasswordSecureField.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/12/21.
//

import SwiftUI

struct LandingSecureField: View {
    
    @State private var showPassword = false
    
    @State var placeholder: String

    @Binding var text: String
    @Binding var isResponder: Bool

    var onCommit: () -> Void
    
    var body: some View {
        if showPassword {
            ResponderTextField(placeholder: placeholder, text: $text, isResponder: $isResponder, returnKeyType: .done) {
                onCommit()
            }
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
            ResponderTextField(placeholder: placeholder, text: $text, isResponder: $isResponder, returnKeyType: .done)  {
                onCommit()
            }
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
            .introspectTextField { (textField) in
                textField.isSecureTextEntry = true
            }
        }
    }
}

struct PasswordSecureField_Previews: PreviewProvider {
    static var previews: some View {
        LandingSecureField(placeholder: "Password", text: .constant(""), isResponder: .constant(false)) {
            print("onCommit...")
        }
    }
}

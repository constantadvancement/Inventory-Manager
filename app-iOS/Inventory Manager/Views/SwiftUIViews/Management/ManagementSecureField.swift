//
//  ManagementSecureField.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/25/21.
//

import SwiftUI

struct ManagementSecureField: View {
    
    @State private var showPassword = false
    
    @State var placeholder: String
    @State var returnKeyType: UIReturnKeyType
    
    @Binding var text: String
    @Binding var isResponder: Bool
    
    var onCommit: () -> Void
    
    var body: some View {
        if showPassword {
            ResponderTextField(placeholder: placeholder, text: $text, isResponder: $isResponder, returnKeyType: returnKeyType)  {
                onCommit()
            }
            .frame(maxWidth: .infinity, maxHeight: 25)
            .padding(15)
            .padding(.trailing, 25)
            .accentColor(Color.primaryHighlight)
            .background(Color.tertiaryBackground)
            .cornerRadius(8)
            .overlay(
                HStack {
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
            ResponderTextField(placeholder: placeholder, text: $text, isResponder: $isResponder, returnKeyType: returnKeyType)  {
                onCommit()
            }
            .frame(maxWidth: .infinity, maxHeight: 25)
            .padding(15)
            .padding(.trailing, 25)
            .accentColor(Color.primaryHighlight)
            .background(Color.tertiaryBackground)
            .cornerRadius(8)
            .overlay(
                HStack {
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

struct EditAccountSecureField_Previews: PreviewProvider {
    static var previews: some View {
        ManagementSecureField(placeholder: "Name", returnKeyType: .next, text: .constant(""), isResponder: .constant(false)) {
            print("onCommit")
        }
    }
}

//
//  EmailTextField.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/12/21.
//

import SwiftUI

struct EmailTextField: View {
    
    @Binding var text: String
    
    var body: some View {
        CustomTextField(placeholder: "Email", text: $text)
            .frame(maxWidth: .infinity, maxHeight: 25)
            .padding(15)
            .padding(.horizontal, 25)
            .accentColor(Color.primaryHighlight)
            .background(Color.tertiaryBackground)
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.secondaryText)
                        .padding(.leading, 15)

                    Spacer()

                    if !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "multiply")
                                .foregroundColor(.secondaryText)
                                .padding(.trailing, 15)
                        }
                    }
                }
            )
    }
}

struct EmailTextField_Previews: PreviewProvider {
    static var previews: some View {
        EmailTextField(text: .constant(""))
    }
}

//
//  TextFieldLarge.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/28/21.
//

import SwiftUI

struct CustomTextField: View {
    
    @State var placeholder: String
    
    @Binding var text: String
    
    var body: some View {
        CustomTextFieldView(placeholder: placeholder, text: $text)
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

struct TextFieldLarge_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(placeholder: "Email", text: .constant(""))
    }
}

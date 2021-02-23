//
//  TextFieldView.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/1/21.
//

// This view creates a custom field field view with zero, one, or two system images positioned to the left or right of the text field.

import SwiftUI

struct BasicTextField: View {
    
    @State var placeholder: String
    @State var imageLeft: String?
    @State var imageRight: String?
    
    @Binding var text: String
    
    var body: some View {
        if let imageLeft = imageLeft, let imageRight = imageRight {
            // Text field with two images
            CustomTextField(placeholder: placeholder, text: $text)
                .frame(maxWidth: .infinity, maxHeight: 25)
                .padding(15)
                .padding(.horizontal, 25)
                .accentColor(Color.primaryHighlight)
                .background(Color.tertiaryBackground)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: imageLeft)
                            .foregroundColor(.secondaryText)
                            .padding(.leading, 15)

                        Spacer()

                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: imageRight)
                                    .foregroundColor(.secondaryText)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                )
        } else if let imageLeft = imageLeft {
            // Text field with one image (left)
            
        } else if let imageRight = imageRight {
            // Text field with one image (right)
            CustomTextField(placeholder: placeholder, text: $text)
                .frame(maxWidth: .infinity, maxHeight: 25)
                .padding(15)
                .padding(.horizontal, 25)
                .accentColor(Color.primaryHighlight)
                .background(Color.tertiaryBackground)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Spacer()

                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: imageRight)
                                    .foregroundColor(.secondaryText)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                )
        } else {
            // Text field with no images
            
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        BasicTextField(placeholder: "Placeholder", text: .constant(""))
    }
}

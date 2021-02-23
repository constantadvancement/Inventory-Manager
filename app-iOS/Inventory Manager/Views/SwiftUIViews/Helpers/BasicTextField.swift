//
//  TextFieldView.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/1/21.
//

import SwiftUI

//struct BasicTextField: View {
//    
//    @State var placeholder: String
//    
//    @State var systemImageLeft: String?
//    @State var systemImageRight: String?
//    
//    @Binding var text: String
//    
//    var body: some View {
//        if let imageLeft = systemImageLeft, let imageRight = systemImageRight {
//            // Text field with two images
//            CustomTextField(placeholder: placeholder, text: $text)  {
//                print("Return clicked")
//            }
//                .frame(maxWidth: .infinity, maxHeight: 25)
//                .padding(15)
//                .padding(.horizontal, 25)
//                .accentColor(Color.primaryHighlight)
//                .background(Color.tertiaryBackground)
//                .cornerRadius(8)
//                .overlay(
//                    HStack {
//                        Image(systemName: imageLeft)
//                            .foregroundColor(.secondaryText)
//                            .padding(.leading, 15)
//
//                        Spacer()
//
//                        if !text.isEmpty {
//                            Button(action: {
//                                self.text = ""
//                            }) {
//                                Image(systemName: imageRight)
//                                    .foregroundColor(.secondaryText)
//                                    .padding(.trailing, 15)
//                            }
//                        }
//                    }
//                )
//        } else if let imageLeft = systemImageLeft {
//            // Text field with one image (left)
//            CustomTextField(placeholder: placeholder, text: $text) {
//                print("Return clicked")
//            }
//                .frame(maxWidth: .infinity, maxHeight: 25)
//                .padding(15)
//                .padding(.leading, 25)
//                .accentColor(Color.primaryHighlight)
//                .background(Color.tertiaryBackground)
//                .cornerRadius(8)
//                .overlay(
//                    HStack {
//                        Image(systemName: imageLeft)
//                            .foregroundColor(.secondaryText)
//                            .padding(.leading, 15)
//                        
//                        Spacer()
//                    }
//                )
//        } else if let imageRight = systemImageRight {
//            // Text field with one image (right)
//            CustomTextField(placeholder: placeholder, text: $text) {
//                print("Return clicked")
//            }
//                .frame(maxWidth: .infinity, maxHeight: 25)
//                .padding(15)
//                .padding(.trailing, 25)
//                .accentColor(Color.primaryHighlight)
//                .background(Color.tertiaryBackground)
//                .cornerRadius(8)
//                .overlay(
//                    HStack {
//                        Spacer()
//
//                        if !text.isEmpty {
//                            Button(action: {
//                                self.text = ""
//                            }) {
//                                Image(systemName: imageRight)
//                                    .foregroundColor(.secondaryText)
//                                    .padding(.trailing, 15)
//                            }
//                        }
//                    }
//                )
//        } else {
//            // Text field with no images
//            CustomTextField(placeholder: placeholder, text: $text) {
//                print("Return clicked")
//            }
//                .frame(maxWidth: .infinity, maxHeight: 25)
//                .padding(15)
//                .accentColor(Color.primaryHighlight)
//                .background(Color.tertiaryBackground)
//                .cornerRadius(8)
//        }
//    }
//}
//
//struct TextFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        BasicTextField(placeholder: "Placeholder", text: .constant(""))
//    }
//}

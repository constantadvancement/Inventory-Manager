//
//  BasicSecureField.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/1/21.
//

import SwiftUI

//struct BasicSecureField: View {
//    
//    @State private var showPassword = false
//    
//    @State var placeholder: String
//    @State var systemImageLeft: String?
//    
//    @Binding var text: String
//    
//    var body: some View {
//        if let imageLeft = systemImageLeft {
//            // Secure field with one image (left)
//            if showPassword {
//                CustomTextField(placeholder: placeholder, text: $text) {
//                    print("Return clicked")
//                }
//                    .frame(maxWidth: .infinity, maxHeight: 25)
//                    .padding(15)
//                    .padding(.horizontal, 25)
//                    .accentColor(Color.primaryHighlight)
//                    .background(Color.tertiaryBackground)
//                    .cornerRadius(8)
//                    .overlay(
//                        HStack {
//                            Image(systemName: imageLeft)
//                                .foregroundColor(.secondaryText)
//                                .padding(.leading, 15)
//
//                            Spacer()
//
//                            if !text.isEmpty {
//                                Button(action: {
//                                    self.showPassword = false
//                                }) {
//                                    Image(systemName: "eye")
//                                        .foregroundColor(.secondaryText)
//                                        .padding(.trailing, 15)
//                                }
//                            }
//                        }
//                    )
//            } else {
//                CustomTextField(placeholder: placeholder, text: $text) {
//                    print("Return clicked")
//                }
//                    .frame(maxWidth: .infinity, maxHeight: 25)
//                    .padding(15)
//                    .padding(.horizontal, 25)
//                    .accentColor(Color.primaryHighlight)
//                    .background(Color.tertiaryBackground)
//                    .cornerRadius(8)
//                    .overlay(
//                        HStack {
//                            Image(systemName: imageLeft)
//                                .foregroundColor(.secondaryText)
//                                .padding(.leading, 15)
//
//                            Spacer()
//
//                            if !text.isEmpty {
//                                Button(action: {
//                                    self.showPassword = true
//                                }) {
//                                    Image(systemName: "eye.slash")
//                                        .foregroundColor(.secondaryText)
//                                        .padding(.trailing, 15)
//                                }
//                            }
//                        }
//                    )
//                    .introspectTextField { (textField) in
//                        textField.isSecureTextEntry = true
//                    }
//            }
//        } else {
//            // Secure field with no image left
//            if showPassword {
//                CustomTextField(placeholder: placeholder, text: $text) {
//                    print("Return clicked")
//                }
//                    .frame(maxWidth: .infinity, maxHeight: 25)
//                    .padding(15)
//                    .padding(.trailing, 25)
//                    .accentColor(Color.primaryHighlight)
//                    .background(Color.tertiaryBackground)
//                    .cornerRadius(8)
//                    .overlay(
//                        HStack {
//                            Spacer()
//
//                            if !text.isEmpty {
//                                Button(action: {
//                                    self.showPassword = false
//                                }) {
//                                    Image(systemName: "eye")
//                                        .foregroundColor(.secondaryText)
//                                        .padding(.trailing, 15)
//                                }
//                            }
//                        }
//                    )
//            } else {
//                CustomTextField(placeholder: placeholder, text: $text) {
//                    print("Return clicked")
//                }
//                    .frame(maxWidth: .infinity, maxHeight: 25)
//                    .padding(15)
//                    .padding(.trailing, 25)
//                    .accentColor(Color.primaryHighlight)
//                    .background(Color.tertiaryBackground)
//                    .cornerRadius(8)
//                    .overlay(
//                        HStack {
//                            Spacer()
//
//                            if !text.isEmpty {
//                                Button(action: {
//                                    self.showPassword = true
//                                }) {
//                                    Image(systemName: "eye.slash")
//                                        .foregroundColor(.secondaryText)
//                                        .padding(.trailing, 15)
//                                }
//                            }
//                        }
//                    )
//                    .introspectTextField { (textField) in
//                        textField.isSecureTextEntry = true
//                    }
//            }
//        }
//    }
//}
//
//struct BasicSecureField_Previews: PreviewProvider {
//    static var previews: some View {
//        BasicSecureField(placeholder: "Placeholder", text: .constant(""))
//    }
//}

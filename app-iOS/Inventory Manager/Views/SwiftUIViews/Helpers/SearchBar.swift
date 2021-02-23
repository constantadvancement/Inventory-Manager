//
//  SearchBar.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/21/20.
//

import SwiftUI
import Introspect

struct SearchBar: View {
    
    @Binding var text: String
        
    var body: some View {
        CustomTextField(placeholder: "Search", text: $text, returnKeyType: .search)
            .frame(maxWidth: .infinity, maxHeight: 25)
            .padding(10)
            .padding(.horizontal, 25)
            .accentColor(Color.primaryHighlight)
            .background(Color.tertiaryBackground)
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)

                    if !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "multiply")
                                .foregroundColor(.secondaryText)
                                .padding(.trailing, 12)
                        }
                    }
                }
            )
    }
        
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}

//
//  ManagementTextField.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/25/21.
//

import SwiftUI

struct ManagementTextField: View {
    
    @State var placeholder: String
    @State var returnKeyType: UIReturnKeyType
    
    @Binding var text: String
    @Binding var isResponder: Bool
    
    var onCommit: () -> Void
    
    var body: some View {
        ResponderTextField(placeholder: placeholder, text: $text, isResponder: $isResponder, returnKeyType: returnKeyType)  {
            onCommit()
        }
        .frame(maxWidth: .infinity, maxHeight: 25)
        .padding(15)
        .accentColor(Color.primaryHighlight)
        .background(Color.tertiaryBackground)
        .cornerRadius(8)
    }
}

struct ManagementTextField_Previews: PreviewProvider {
    static var previews: some View {
        ManagementTextField(placeholder: "Name", returnKeyType: .next, text: .constant(""), isResponder: .constant(false)) {
            print("onCommit")
        }
    }
}

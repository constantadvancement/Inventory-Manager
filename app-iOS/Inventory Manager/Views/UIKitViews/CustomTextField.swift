//
//  CustomTextField2.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/22/21.
//

import SwiftUI

struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var onCommit: (() -> Void)?

        init(text: Binding<String>, onCommit: (() -> Void)?) {
            self._text = text
            self.onCommit = onCommit
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            if let onCommit = onCommit {
                onCommit()
            }
            return true
        }
        
    }

    var placeholder: String
    @Binding var text: String
    var returnKeyType: UIReturnKeyType
    var onCommit: (() -> Void)? = nil

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // Configuration
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor(Color.secondaryText)])
        textField.textColor = UIColor(Color.primaryText)
        
        textField.returnKeyType = returnKeyType
        
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text, onCommit: onCommit)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
    }

}

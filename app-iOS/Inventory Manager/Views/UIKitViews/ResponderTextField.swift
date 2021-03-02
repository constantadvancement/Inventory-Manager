//
//  ResponderTextField.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/23/21.
//

import SwiftUI

struct ResponderTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        @Binding var isResponder : Bool
        var onCommit: (() -> Void)?

        init(text: Binding<String>, isResponder : Binding<Bool>, onCommit: (() -> Void)?) {
            self._text = text
            self._isResponder = isResponder
            self.onCommit = onCommit
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [self] in
                text = textField.text ?? ""
            }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async { [self] in
                isResponder = true
            }
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            DispatchQueue.main.async { [self] in
                isResponder = false
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let onCommit = onCommit {
                onCommit()
            }
            return true
        }
        
    }

    var placeholder: String
    @Binding var text: String
    @Binding var isResponder: Bool
    var returnKeyType: UIReturnKeyType
    var onCommit: (() -> Void)? = nil

    func makeUIView(context: UIViewRepresentableContext<ResponderTextField>) -> UITextField {
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

    func makeCoordinator() -> ResponderTextField.Coordinator {
        return Coordinator(text: $text, isResponder: $isResponder, onCommit: onCommit)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<ResponderTextField>) {
        uiView.text = text
        
        if isResponder {
            uiView.becomeFirstResponder()
        }
    }

}

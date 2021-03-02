//
//  TextSelector.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/25/21.
//

import Foundation
import SwiftUI

struct TextSelector: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        var text: String

        init(text: String) {
            self.text = text
        }
        
        
    }

    var text: String

    func makeUIView(context: UIViewRepresentableContext<TextSelector>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // Configuration
        textField.textColor = UIColor(Color.primaryText)

        
        return textField
    }

    func makeCoordinator() -> TextSelector.Coordinator {
        return Coordinator(text: text)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextSelector>) {
        uiView.text = text
    }

}

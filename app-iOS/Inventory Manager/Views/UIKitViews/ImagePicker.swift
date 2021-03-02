//
//  ImagePicker.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/21/21.
//

import SwiftUI
import Foundation

struct ImagePicker: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let uiImage = info[.editedImage] as? UIImage {
//                parent.image = uiImage
//            }

            parent.presentationMode.wrappedValue.dismiss()
        }
        
        
    }
    
    @Environment(\.presentationMode) var presentationMode
//    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        // Image picker styling
        picker.view.tintColor = UIColor(Color.primaryHighlight)
        
        // Image picker configuration
        picker.allowsEditing = true
        
        picker.isNavigationBarHidden = true
        
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

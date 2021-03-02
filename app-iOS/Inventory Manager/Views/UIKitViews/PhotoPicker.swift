//
//  PHPicker.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/26/21.
//

import Foundation
import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentationMode
    let completionHandler: (_ selectedImage: UIImage) -> Void

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration: PHPickerConfiguration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        configuration.preferredAssetRepresentationMode = .current
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
    
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: PHPickerViewControllerDelegate {

        private let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard results.count == 1 else {
                parent.presentationMode.wrappedValue.dismiss()
                return
            }
            let image = results[0]
            if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                image.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async { [self] in
                         if let image = image as? UIImage {
                            parent.completionHandler(image)
                         }
                     }
                }
            }

            parent.presentationMode.wrappedValue.dismiss()
            
//            picker.dismiss(animated: true)
        }
        
        
        
    }
}

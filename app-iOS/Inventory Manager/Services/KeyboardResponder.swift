//
//  KeyboardResponder.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/22/21.
//

import Foundation
import SwiftUI
import Combine

//final class KeyboardResponder: ObservableObject {
//    let didChange = PassthroughSubject<CGFloat, Never>()
//    private var _center: NotificationCenter
//    private(set) var currentHeight: CGFloat = 0 {
//        didSet {
//            didChange.send(currentHeight)
//        }
//    }
//
//    init(center: NotificationCenter = .default) {
//        _center = center
//        _center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        _center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    deinit {
//        _center.removeObserver(self)
//    }
//
//    @objc func keyBoardWillShow(notification: Notification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            currentHeight = keyboardSize.height
//        }
//    }
//
//    @objc func keyBoardWillHide(notification: Notification) {
//        currentHeight = 0
//    }
//}

class KeyboardResponder: ObservableObject {

    @Published var currentHeight: CGFloat = 0
    var _center: NotificationCenter

    init(center: NotificationCenter = .default) {
        _center = center

        _center.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        _center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        _center.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
            print("keyboardWillShow \(currentHeight)")
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        currentHeight = 0
        print("keyboardWillHide \(currentHeight)")
    }

//    @objc func keyboardWillShow(notification: Notification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            withAnimation {
//                currentHeight = keyboardSize.height
//                print("keyboardWillShow \(currentHeight)")
//            }
//        }
//    }
//    @objc func keyboardWillHide(notification: Notification) {
//        withAnimation {
//            currentHeight = 0
//            print("keyboardWillHide \(currentHeight)")
//        }
//    }


}

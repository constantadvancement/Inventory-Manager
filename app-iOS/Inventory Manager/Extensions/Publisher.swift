//
//  Publisher.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 2/22/21.
//

import Foundation
import Combine
import SwiftUI

//extension Publishers {
//    // 1.
//    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
//        // 2.
//        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification).map { (notification) in
//            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
//        }
//        
//        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification).map { _ in
//            CGFloat(0)
//        }
//        
//        // 3.
//        return MergeMany(willShow, willHide)
//            .eraseToAnyPublisher()
//    }
//}

//
//  ProgressSpinner.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/29/20.
//

import SwiftUI

struct ProgressSpinner: View {
    
    @State var color: Color = Color.primaryHighlight
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: color))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProgressSpinner_Previews: PreviewProvider {
    static var previews: some View {
        ProgressSpinner()
    }
}

//
//  InventoryActions.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/4/21.
//

import SwiftUI

struct DeleteButton: View {
    
    @Binding var showingAlert: Bool
    
    var body: some View {
        ZStack {
            Color.red
                .frame(width: 175, height: 40)
                .cornerRadius(30)
            
            Button(action: {
                withAnimation(Animation.linear.speed(2.0)) {
                    self.showingAlert.toggle()
                }
            }) {
                Text("Delete")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primaryText)
                    .frame(width: 175, height: 40)
            }
        }
    }
}

struct InventoryActions_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton(showingAlert: .constant(true))
    }
}

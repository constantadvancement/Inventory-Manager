//
//  AlertView.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/6/21.
//

import SwiftUI

struct DeleteAlert: View {
    
    @EnvironmentObject var userObject: UserObject
    @EnvironmentObject var inventoryObject: InventoryObject
    
    @State var inventory: Inventory
    
    @Binding var isShowing: Bool

    var body: some View {
        if isShowing {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    VStack {
                        // Title
                        Text("Unregister Device")
                            .font(.headline)
                            .foregroundColor(Color.primaryText)
                            .padding(.bottom, 5)
                        
                        // Prompt
                        Text("This will permanently delete all data associated with this device.")
                            .font(.subheadline)
                            .foregroundColor(Color.primaryText)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    HStack {
                        // Cancel Button
                        Button(action: {
                            withAnimation(Animation.linear.speed(2.0)) {
                                self.isShowing.toggle()
                            }
                        }) {
                            Text("Cancel")
                                .font(.headline)
                                .foregroundColor(Color.primaryHighlight)
                                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .center)
                        }
                        
                        // Delete Button
                        Button(action: {
                            withAnimation(Animation.linear.speed(2.0)) {
                                self.isShowing.toggle()
                            }
                            NotificationCenter.default.post(name: .closeDetailView, object: nil)
                            inventoryObject.deleteInventory(apiKey: userObject.user?.apiKey ?? nil, serialNumber: inventory.device.serialNumber)
                        }) {
                            Text("Delete")
                                .font(.headline)
                                .foregroundColor(Color.red)
                                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .center)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)                    
                    .applyHorizontalBorder(color: Color.primaryBackground, thickness: 1, alignment: .top)
                    .applyVerticalBorder(color: Color.primaryBackground, thickness: 1, alignment: .center)

                }
                .background(Color.secondaryBackground)
                .frame(maxWidth: min(geometry.size.width * 0.7 , 300))
                .cornerRadius(8.0)
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct DeleteAlert_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAlert(inventory: INVENTORY, isShowing: .constant(true))
    }
}

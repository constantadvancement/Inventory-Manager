//
//  InventoryDetail.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/14/20.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    @EnvironmentObject var userObject: UserObject
    @EnvironmentObject var inventoryObject: InventoryObject
    
    @State private var showingAlert = false
    @State var inventory: Inventory
    
    var body: some View {
        VStack(spacing: 0) {
            DetailHeader(inventory: inventory)
                .padding()
                .border(width: 2, edges: [.bottom], color: Color.tertiaryBackground)
        
            MapView(coordinate: inventory.locations[0].coordinate)
                .overlay(
                    Text("Last reported location")
                        .padding(10)
                        .font(.subheadline)
                        .foregroundColor(Color.secondaryText),
                    alignment: .topLeading
                )
                .border(width: 2, edges: [.bottom], color: Color.tertiaryBackground)

            ScrollView {
                InventoryDetail(inventory: inventory).padding()

                // Show delete button only if this user is an admin
                if userObject.user?.role == 1 {
                    DeleteButton(showingAlert: $showingAlert).padding()
                }
            }
            .background(Color.secondaryBackground.ignoresSafeArea())
        }
        .background(Color.primaryBackground.ignoresSafeArea())
        .alert(isPresented: $showingAlert) {
            let primaryButton = Alert.Button.destructive(Text("Delete")) {
                inventoryObject.deleteInventory(apiKey: userObject.user?.apiKey ?? nil, serialNumber: inventory.device.serialNumber)
            }
            let secondaryButton = Alert.Button.cancel(Text("Cancel").foregroundColor(Color.red)) {
                showingAlert = false
            }
            return Alert(title: Text("Unregister device?"), message: Text("This will permanently delete all data associated with this device."), primaryButton: primaryButton, secondaryButton: secondaryButton)

        }
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(inventory: INVENTORY)
    }
}

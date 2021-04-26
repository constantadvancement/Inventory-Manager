//
//  InventoryDetail.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/31/20.
//

import SwiftUI

struct InventoryDetail: View {
    
    @EnvironmentObject var inventoryObject: InventoryObject
    
    @State var inventory: Inventory
    
    var body: some View {
        VStack {
            // Employee details
            VStack(spacing: 8) {
                Text("Employee")
                    .font(.title3)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .border(width: 1, edges: [.bottom], color: Color.primaryBackground)
                
                InventoryDetailEntry(header: "Name", text: inventory.holder.name)
                InventoryDetailEntryAction(header: "Email", text: inventory.holder.email) {
                    guard let url = URL(string: "mailto:\(inventory.holder.email)") else { return }
                    UIApplication.shared.open(url)
                }
                InventoryDetailEntryAction(header: "Phone", text: inventory.holder.phone) {
                    guard let url = URL(string: "tel://\(inventory.holder.phone)") else { return }
                    UIApplication.shared.open(url)
                }
            }
            .padding(.bottom)
            
            // Device details
            VStack(spacing: 8) {
                Text("Device")
                    .font(.title3)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .border(width: 1, edges: [.bottom], color: Color.primaryBackground)

                InventoryDetailEntry(header: "Model Name", text: inventory.device.modelName)
                InventoryDetailEntry(header: "Model Identifier", text: inventory.device.modelIdentifier)
                InventoryDetailEntry(header: "Model Number", text: inventory.device.modelNumber)
                InventoryDetailEntry(header: "Serial Number", text: inventory.device.serialNumber)
                InventoryDetailEntry(header: "Hardware UUID", text: inventory.device.hardwareUUID)
            }
            .padding(.bottom)

            // Location details
            VStack(spacing: 8) {
                Text("Location")
                    .font(.title3)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .border(width: 1, edges: [.bottom], color: Color.primaryBackground)

                InventoryDetailEntry(header: "Address", text: inventoryObject.lastValidLocation(locations: inventory.locations).address)
                InventoryDetailEntry(header: "Timestamp", text: inventoryObject.lastValidLocation(locations: inventory.locations).timestamp)
                InventoryDetailEntry(header: "Status", text: inventoryObject.lastValidLocation(locations: inventory.locations).status)
            }
        }
        .foregroundColor(Color.primaryText)
    }
}

private struct InventoryDetailEntry: View {
    
    @State var header: String
    @State var text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(header).fontWeight(.semibold)
                .frame(width: 150, alignment: .leading)
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .fixedSize(horizontal: false, vertical: true)
        .foregroundColor(Color.primaryText)
    }
}

private struct InventoryDetailEntryAction: View {
    
    @State var header: String
    @State var text: String
    
    var action: () -> Void
    
    var body: some View {
        HStack(alignment: .top) {
            Text(header).fontWeight(.semibold)
                .frame(width: 150, alignment: .leading)
            Button(action: {
                action()
            }) {
                Text(text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .foregroundColor(Color.primaryText)
    }
}

struct InventoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        InventoryDetail(inventory: INVENTORY)
    }
}

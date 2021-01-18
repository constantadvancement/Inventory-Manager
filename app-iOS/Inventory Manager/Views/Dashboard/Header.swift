//
//  Header.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/22/20.
//

import SwiftUI

struct DashboardHeader: View {
    var body: some View {
        HStack {
            Text("CA Inventory Manager")
                .font(.headline)
                .foregroundColor(.primaryText)
            
            Spacer()
            
            Button(action: {
                print("Implement settings view")//TODO
            }) {
                Image(systemName: "gearshape")
                    .foregroundColor(.primaryText)
            }
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        DashboardHeader()
    }
}

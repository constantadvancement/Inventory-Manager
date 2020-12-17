//
//  InventoryList.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/14/20.
//

import SwiftUI

struct InventoryList: View {
    
    @State var inventoryList = [Inventory]()
    
    var body: some View {
        NavigationView {
            List(inventoryList, id: \.device.serialNumber) { inventory in
                
                NavigationLink(destination: InventoryDetail(inventory: inventory)) {
                    InventoryRow(inventory: inventory)
//                    Text(inventory.holder.name)
//                        .padding()
                }
    
            }
            .navigationTitle("Inventory")
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        let http = HttpClient()
        http.GET(url: "http://localhost:3000/inventory") { (err: Error?, data: Data?) in
            guard data != nil else {
                // Failure; a server or client error occurred
                print("Server or client error has occurred!")
                
                // TODO; handle this....
                return
            }

            if let data = try? JSONDecoder().decode([Inventory].self, from: data!) {
                DispatchQueue.main.async { [self] in
                    print(data)
                    inventoryList = data
                }
            } else {
                // TODO; failed to decode... handle this?
            }
        }
    }
}

struct InventoryList_Previews: PreviewProvider {
    static var previews: some View {
        InventoryList()
    }
}

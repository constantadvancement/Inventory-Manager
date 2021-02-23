//
//  CustomList.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/7/21.
//

import SwiftUI

struct ListItem: Hashable {
    var id = UUID()
    var data: Any
    
    static func == (lhs: ListItem, rhs: ListItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct CustomList: View {
    
    @State var list: [Any]
    
    @State private var listItems = [ListItem]()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(listItems, id: \.self) { item in
                        VStack(alignment: .leading) {
//                            Text(item.data)
                        }
                        .foregroundColor(Color.primaryText)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
    //                    .overlay(
    //                        Rectangle()
    //                            .frame(height: 1)
    //                            .foregroundColor(Color.primaryBackground),
    //                        alignment: .top
    //                    )
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.primaryBackground),
                            alignment: .bottom
                        )
    //                    .padding(.top, 3)
    //                    .padding(.bottom, 3)
                    }
                }
            }
            .background(Color.secondaryBackground.ignoresSafeArea())
        }
        .onAppear {
            for item in list {
                listItems.append(ListItem(data: item))
            }
            
            print(listItems)
        }
    }
}

struct CustomList_Previews: PreviewProvider {
    static var previews: some View {
        CustomList(list: INVENTORY_LIST)
    }
}

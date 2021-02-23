//
//  Account.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/19/21.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var user: UserObject
    
    var body: some View {
        VStack {
            Text(user.user?.email ?? "")
        }
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

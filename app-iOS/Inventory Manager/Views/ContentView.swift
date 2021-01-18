//
//  ContentView.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 12/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        ZStack {
            if(user.isLoggedIn) {
                DashboardView()
            } else {
                LandingView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

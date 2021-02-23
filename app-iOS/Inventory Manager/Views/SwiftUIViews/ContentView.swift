//
//  ContentView.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 12/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userObject: UserObject
        
    var body: some View {
        ZStack {
            if userObject.isLoggedIn {
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

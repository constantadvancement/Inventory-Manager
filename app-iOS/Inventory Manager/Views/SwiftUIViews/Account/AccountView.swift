//
//  Settings.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/21/20.
//

import SwiftUI

struct AccountView: View {    
    var body: some View {
        VStack(spacing: 0) {
            AccountHeader()
                .padding()
                .applyHorizontalBorder(color: Color.tertiaryBackground, alignment: .bottom)
            
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        AccountImage(imageOnly: false)
                            .padding(.bottom)
                        
                        AccountDetail()
                        
                        Spacer()
                        
                        LogoutButton()
                    }
                    .padding()
                    .frame(minHeight: geometry.size.height)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.secondaryBackground.ignoresSafeArea())
            }
        }
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

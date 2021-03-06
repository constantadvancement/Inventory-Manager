//
//  ManagementView.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/28/21.
//

import SwiftUI

struct ManagementView: View {
    
    @State private var type: AccountManagementType = .information
    
    var body: some View {
        VStack(spacing: 0) {
            ManagementHeader(type: $type)
                .padding()
                .border(width: 2, edges: [.bottom], color: Color.tertiaryBackground)
            
            ScrollView {
                VStack {
                    AccountImage(imageOnly: true)
                        .padding(.bottom)
                    
                    if type == .information {
                        UpdateInformationView()
                    } else {
                        UpdatePasswordView()
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.secondaryBackground.ignoresSafeArea())
        }
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}

struct EditInformation_Previews: PreviewProvider {
    static var previews: some View {
        ManagementView()
    }
}

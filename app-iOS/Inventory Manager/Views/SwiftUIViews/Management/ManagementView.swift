//
//  ManagementView.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/28/21.
//

import SwiftUI

struct ManagementView: View {
    
    @State private var type: ManagementType = .information
    
    var body: some View {
        VStack(spacing: 0) {
            ManagementHeader(type: $type)
                .padding()
                .applyHorizontalBorder(color: Color.tertiaryBackground, alignment: .bottom)
            
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

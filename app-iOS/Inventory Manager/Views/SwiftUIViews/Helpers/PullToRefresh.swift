//
//  PullToRefresh.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/26/21.
//

import SwiftUI

struct PullToRefresh: View {
    
    var coordinateSpaceName: String = .pullToRefresh
    var onRefresh: () -> Void
    
    @State private var shouldRefresh: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.frame(in: .named(coordinateSpaceName)).midY > 65 {
                Spacer()
                    .onAppear {
                        shouldRefresh = true
                    }
            } else if geometry.frame(in: .named(coordinateSpaceName)).maxY < 10 {
                Spacer()
                    .onAppear {
                        if shouldRefresh {
                            shouldRefresh = false
                            onRefresh()
                        }
                    }
            }
            
            HStack(spacing: 0) {
                if shouldRefresh {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.primaryHighlight))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    EmptyView()
                }
            }
        }
        .padding(.top, -130)
    }
}

struct PullToRefresh_Previews: PreviewProvider {
    static var previews: some View {
        PullToRefresh() {
            print("On refresh...")
        }
    }
}

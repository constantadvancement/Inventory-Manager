//
//  Account.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/19/21.
//

import SwiftUI

struct AccountImage: View {
    
    @EnvironmentObject var userObject: UserObject
    
    @State var imageOnly: Bool
    
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            VStack {
                if let uiImage = userObject.user?.uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                        .onTapGesture {
                            if !imageOnly {
                                self.showingImagePicker = true
                            }
                        }
                } else {
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .padding(37.5)
                            .background(Color.primaryBackground)
                            .clipShape(Circle())
                        if !imageOnly {
                            Image(systemName: "plus")
                                .foregroundColor(Color.white)
                                .frame(width: 30, height: 30)
                                .background(Color.primaryHighlight)
                                .clipShape(Circle())
                        }
                     }
                    .onTapGesture {
                        if !imageOnly {
                            self.showingImagePicker = true
                        }
                    }
                }
                
                if !imageOnly {
                    Button(action: {
                        self.showingImagePicker = true
                    }){
                        if userObject.user?.uiImage != nil {
                            Text("Change Photo")
                                .font(.subheadline)
                                .foregroundColor(Color.secondaryText)
                        } else {
                            Text("Upload Photo")
                                .font(.subheadline)
                                .foregroundColor(Color.secondaryText)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: setImage) {
            ImagePicker(image: $selectedImage)
        }
    }
    
    private func setImage() {
        guard let uiImage = selectedImage else { return }
        userObject.setImage(uiImage: uiImage) { (result) in
            return
        }
    }
}

struct AccountImage_Previews: PreviewProvider {
    static var previews: some View {
        AccountImage(imageOnly: true)
            .environmentObject(UserObject())
    }
}

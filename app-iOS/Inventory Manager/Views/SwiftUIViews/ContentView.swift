//
//  ContentView.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 12/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userObject: UserObject
        
    @State var faceIDFailure: Bool = false
    @State var faceIDNewDevice: Bool = false
        
    var body: some View {
        ZStack {
            if userObject.isLoggedIn {
                DashboardView()
            } else {
                LandingView()
            }
        }
        .onAppear(perform: biometricAuthentication)
        .alert(isPresented: $faceIDFailure) {
            Alert(title: Text("Face ID"), message: Text("An error occurred, please login using your account's credentials!"), dismissButton: .default(Text("Okay")))
        }
        .alert(isPresented: $faceIDNewDevice) {
            Alert(title: Text("Face ID"), message: Text("Log in using your account's credentials to finish setting up Face ID for this device!"), dismissButton: .default(Text("Okay")))
        }
    }
    
    private func biometricAuthentication() {
        let faceID = FacialRecognition()
        faceID.authenticate { (result: Bool?) in
            if let result = result, result == true {
                userObject.bioAuthentication = true
                guard let uuid = UIDevice.current.identifierForVendor?.uuidString else {
                    faceIDFailure = true
                    return
                }
                userObject.login(deviceUuid: uuid) { (result: Bool?) in
                    if let result = result {
                        if result == false {
                            faceIDFailure = true
                        }
                    } else {
                        faceIDNewDevice = true
                    }
                }
            } else {
                userObject.bioAuthentication = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

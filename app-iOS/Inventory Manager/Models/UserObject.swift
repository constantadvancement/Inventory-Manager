//
//  User.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/11/21.
//

import Foundation

struct UserModel: Codable {
    var id: Int
    var email: String
    var role: Int
    var apiKey: String
}

class UserObject: ObservableObject {
    @Published var user: UserModel?
    @Published var isLoggedIn: Bool
    
    init() {
        self.user = nil
        self.isLoggedIn = false
    }
    
    // Attempts to login using the provided credentials
    func login(email: String, password: String) {
        var authentication = [String: String]()
        authentication["email"] = email
        authentication["password"] = password
        
        var data: Data?
        do {
            data = try JSONSerialization.data(withJSONObject: authentication, options: .prettyPrinted)
        } catch {
            data = nil
        }
        
        let http = HttpClient()
        http.POST(url: "http://localhost:3000/local/user/login", body: data) { (err: Error?, data: Data?) in
            guard data != nil else {
                // Server or client error authentication event
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .authenticationError, object: nil)
                }
                return
            }
            
            if let user = try? JSONDecoder().decode(UserModel.self, from: data!) {
                // Authentication success
                DispatchQueue.main.async { [self] in
                    self.user = user
                    self.isLoggedIn = true
                }
            } else {
                // Authentication failiure
                DispatchQueue.main.async { [self] in
                    self.user = nil
                    self.isLoggedIn = false
                    // Authentication failure event
                    NotificationCenter.default.post(name: .authenticationFailure, object: nil)
                }
            }
        }
    }
    
    // Logout of the current user
    func logout() {
        self.user = nil
        self.isLoggedIn = false
    }
}

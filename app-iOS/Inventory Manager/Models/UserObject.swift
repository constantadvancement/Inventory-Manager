//
//  User.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 1/11/21.
//

import Foundation
import SwiftUI

struct User: Codable {
    var id: Int
    
    var name: String
    var email: String
    var phone: String
    
    var imageData: String?
    var uiImage: UIImage? {
        guard let imageData = imageData else { return nil }
        if let data = Data(base64Encoded: imageData) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
    
    var role: Int
    var apiKey: String
}

class UserObject: ObservableObject {
    @Published var user: User?
    @Published var isLoggedIn: Bool
    @Published var bioAuthentication: Bool
    
    init() {
        self.user = nil
        self.isLoggedIn = false
        self.bioAuthentication = false
    }
    
    // User Authentication Functions
    
    /**
     Attempts to login using the provided credentials
     */
    func login(email: String, password: String, callback: @escaping (Bool?) -> Void) {
        var body = [String: String]()
        body["email"] = email
        body["password"] = password
        if let uuid = UIDevice.current.identifierForVendor?.uuidString, bioAuthentication {
            body["deviceUuid"] = uuid
        }
        
        var bodyData: Data?
        do {
            bodyData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch {
            bodyData = nil
        }
        
        let http = HttpClient()
        http.POST(url: "\(String.production)/local/user/login", body: bodyData) { (err: Error?, data: Data?) in
            guard data != nil else {
                // Server or client error
                DispatchQueue.main.async {[self] in
                    self.user = nil
                    self.isLoggedIn = false
                }
                return callback(nil)
            }
            
            if let user = try? JSONDecoder().decode(User.self, from: data!) {
                // Authentication success
                DispatchQueue.main.async { [self] in
                    self.user = user
                    self.isLoggedIn = true
                }
                return callback(true)
            } else {
                // Authentication failiure
                DispatchQueue.main.async { [self] in
                    self.user = nil
                    self.isLoggedIn = false
                }
                return callback(false)
            }
        }
    }
    
    /**
     Attempts to login using the trusted device ID (via biometric authentication)
     */
    func login(deviceUuid: String, callback: @escaping (Bool?) -> Void) {
        var body = [String: String]()
        body["deviceUuid"] = deviceUuid
        
        var bodyData: Data?
        do {
            bodyData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch {
            bodyData = nil
        }
        
        let http = HttpClient()
        http.POST(url: "\(String.production)/local/user/login/faceId", body: bodyData) { (err: Error?, data: Data?) in
            guard data != nil else {
                // Server or client error
                DispatchQueue.main.async {[self] in
                    self.user = nil
                    self.isLoggedIn = false
                }
                return callback(nil)
            }
            
            if let user = try? JSONDecoder().decode(User.self, from: data!) {
                // Authentication success
                DispatchQueue.main.async { [self] in
                    self.user = user
                    self.isLoggedIn = true
                }
                return callback(true)
            } else {
                // Authentication failiure
                DispatchQueue.main.async { [self] in
                    self.user = nil
                    self.isLoggedIn = false
                }
                return callback(false)
            }
        }
    }
    
    /**
     Logs out of the current user
     */
    func logout() {
        self.user = nil
        self.isLoggedIn = false
    }

    // Account Management Functions
    
    /**
     Updates this user's password to the newly provided password if the given current password matches their existing password.
     */
    func changePassword(currentPassword: String, newPassword: String, callback: @escaping (Bool?) -> Void) {
        guard let apiKey = self.user?.apiKey else { return }
        
        var body = [String: String]()
        body["currentPassword"] = currentPassword
        body["newPassword"] = newPassword
        
        var bodyData: Data?
        do {
            bodyData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch {
            bodyData = nil
        }
        
        let http = HttpClient()
        http.POST(url: "\(String.production)/\(apiKey)/user/password/change", body: bodyData) { (err: Error?, data: Data?) in
            guard data != nil else {
                // Server or client error
                return callback(nil)
            }

            if let result = try? JSONDecoder().decode(Bool.self, from: data!) {
                // Success or failure status
                return callback(result)
            } else {
                // Unknown error
                return callback(nil)
            }
        }
    }
    
    /**
     Edits this user's account information, including their name, email, and phone attributes.
     */
    func editAccount(name: String, email: String, phone: String, callback: @escaping (Bool?) -> Void) {
        guard let apiKey = self.user?.apiKey else { return }
        
        var body = [String: String]()
        body["name"] = name
        body["email"] = email
        body["phone"] = phone
        
        var bodyData: Data?
        do {
            bodyData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch {
            bodyData = nil
        }
        
        // Server update
        let http = HttpClient()
        http.POST(url: "\(String.production)/\(apiKey)/user/account/edit", body: bodyData) { (err: Error?, data: Data?) in
            guard data != nil else {
                // Server or client error
                return callback(nil)
            }

            if let result = try? JSONDecoder().decode(Bool.self, from: data!) {
                if result {
                    // Success status
                    DispatchQueue.main.async { [self] in
                        // Local update
                        self.user?.name = name
                        self.user?.email = email
                        self.user?.phone = phone
                        self.objectWillChange.send()
                    }
                    return callback(result)
                } else {
                    // Failure status
                    return callback(result)
                }
            } else {
                // Unknown error
                return callback(nil)
            }
        }
    }
    
    /**
     Updates or creates this user's image on the server
     */
    func setImage(uiImage: UIImage, callback: @escaping (Bool?) -> Void) {
        guard let apiKey = self.user?.apiKey else { return }
        
        // Local update
        DispatchQueue.main.async { [self] in
            guard let data = uiImage.jpegData(compressionQuality: 0) else { return callback(false) }
            self.user?.imageData = data.base64EncodedString(options: NSData.Base64EncodingOptions())
            self.objectWillChange.send()
        }
        
        // Server update
        let http = HttpClient()
        http.POSTImage(url: "\(String.production)/\(apiKey)/user/image/set", uiImage: uiImage, imageName: "\(apiKey).png") { (err: Error?, data: Data?) in
            guard data != nil else {
                // Server or client error
                return callback(nil)
            }

            if let result = try? JSONDecoder().decode(Bool.self, from: data!) {
                if result {
                    // Success status
                    return callback(result)
                } else {
                    // Failure status
                    return callback(result)
                }
            } else {
                // Unknown error
                return callback(nil)
            }
        }
    }
    
}

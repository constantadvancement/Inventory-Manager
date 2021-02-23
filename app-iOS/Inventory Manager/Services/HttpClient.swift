//
//  HttpClient.swift
//  InventoryManager
//
//  Created by Ryan Mackin on 12/11/20.
//

import Foundation
import SwiftUI

class HttpClient {
    
    init() { }
    
    func GET(url: String, _ callback: @escaping (Error?, Data?) -> ()) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, err: Error?) in
            guard err == nil, data != nil else {
                // Client error
                return callback(err, nil)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // Server error
                return callback(nil, nil)
            }

            return callback(nil, data)
        }.resume()
    }
    
    func POST(url: String, body: Data?, _ callback: @escaping (Error?, Data?) -> ()) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, err: Error?) in
            guard err == nil, data != nil else {
                // Client error
                return callback(err, nil)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // Server error
                return callback(nil, nil)
            }

            return callback(nil, data)
        }.resume()
    }

    func POSTImage(url: String, uiImage: UIImage, imageName: String, _ callback: @escaping (Error?, Data?) -> ()) {
        let boundary = UUID().uuidString
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"userImage\"; filename=\"\(imageName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(uiImage.jpegData(compressionQuality: 0)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        let session = URLSession.shared
        session.uploadTask(with: urlRequest, from: data) { (data: Data?, response: URLResponse?, err: Error?) in
            guard err == nil, data != nil else {
                // Client error
                return callback(err, nil)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // Server error
                return callback(nil, nil)
            }

            return callback(nil, data)
        }.resume()
    }

}

//
//  HttpClient.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 10/29/20.
//

import Foundation

class HttpClient {
    
    init() { }
    
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
}

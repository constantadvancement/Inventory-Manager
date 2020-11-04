//
//  HttpClient.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 10/29/20.
//

import Foundation

class HttpClient {
    
    init() {}
    
    func POST(url: String, body: Data?, _ callback: @escaping (Error?, Data?) -> ()) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, err: Error?) in
            guard err == nil, data != nil else {
                print("Client error!")
                callback(err, nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Server error!")
                print(err?.localizedDescription)
                callback(err, nil)
                return
            }

            callback(nil, data)
            return
        }.resume()
    }
    
    func GET(url: String, body: Data?, _ callback: @escaping (Error?, Data?) -> ()) {
        // TODO http get implementation
    }
}

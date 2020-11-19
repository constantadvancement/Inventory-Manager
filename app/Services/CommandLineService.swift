//
//  CommandLineService.swift
//  Inventory Manager
//
//  Created by Ryan Mackin on 11/12/20.
//

import Foundation

class CommandLineService {
    
    init() { }

    // Executes the provided command with root privileges, requires the user to manually enter their username and password
    func executeAsRootNoCredentials(command: String) -> String {
        var arguments:[String] = []
        arguments.append("-c")
        let arg = "osascript -e 'do shell script \"\(command)\" with administrator privileges'"
        arguments.append(arg)

        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = arguments

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        task.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()

        return String(data: data, encoding: .utf8)!
    }
    
    // Executes the provided command with root privileges, given that the sudo username and password is also provided
    func executeAsRoot(command: String, username: String, password: String) -> String {
        var arguments:[String] = []
        arguments.append("-c")
        let arg = "osascript -e 'do shell script \"\(command)\" user name \"\(username)\" password \"\(password)\" with administrator privileges'"
        arguments.append(arg)

        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = arguments

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        task.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()

        return String(data: data, encoding: .utf8)!
    }
    
    // Executes the provided command without root privileges
    func execute(command: String) -> String {
        var arguments:[String] = []
        arguments.append("-c")
        arguments.append(command)

        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = arguments

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        task.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()

        return String(data: data, encoding: .utf8)!
    }
}

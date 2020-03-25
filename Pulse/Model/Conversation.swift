//
//  Conversation.swift
//  Pulse
//
//  Created by Luke Klinker on 1/1/18.
//  Copyright © 2018 Luke Klinker. All rights reserved.
//

import Alamofire

struct Conversation : ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    
    let id: Int64
    let title: String
    let phoneNumbers: String
    var snippet: String
    var timestamp: Int64
    var read: Bool
    let pinned: Bool
    let color: Int
    let colorDark: Int
    let colorAccent: Int
    
    var description: String {
        return "Conversation: { title: \(title), snippet: \(snippet), timestamp: \(timestamp) }"
    }
    
    init?(json: Any) {
        guard
            let json = json as? [String: Any],
            let id = json["device_id"] as? Int64,
            let title = json["title"] as? String,
            let phoneNumbers = json["phone_numbers"] as? String,
            let snippet = json["snippet"] as? String,
            let timestamp = json["timestamp"] as? Int64,
            let read = json["read"] as? Bool,
            let pinned = json["pinned"] as? Bool,
            let color = json["color"] as? Int,
            let colorDark = json["color_dark"] as? Int,
            let colorAccent = json["color_accent"] as? Int
        else { return nil }
        
        self.id = id
        self.title = Account.encryptionUtils?.decrypt(data: title) ?? ""
        self.phoneNumbers = Account.encryptionUtils?.decrypt(data: phoneNumbers) ?? ""
        self.snippet = Account.encryptionUtils?.decrypt(data: snippet) ?? ""
        self.timestamp = timestamp
        self.read = read
        self.pinned = pinned
        self.color = color
        self.colorDark = colorDark
        self.colorAccent = colorAccent
    }
    
    func isGroup() -> Bool {
        return phoneNumbers.contains(",")
    }
}

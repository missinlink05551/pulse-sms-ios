//
//  ScheduledMessage.swift
//  Pulse
//
//  Created by Luke Klinker on 1/10/18.
//  Copyright © 2018 Luke Klinker. All rights reserved.
//

import Alamofire

struct ScheduledMessage : ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    
    let id: Int64
    let title: String
    let to: String
    let data: String
    let mimeType: String
    let timestamp: Int64
    
    var description: String {
        return "Scheduled Message: { to: \(to), data: \(data), mime_type: \(mimeType), title: \(title), timestamp: \(timestamp) }"
    }
    
    init(id: Int64, title: String, phoneNumbers: String, data: String, mimeType: String, timestamp: Int64) {
        self.id = id
        self.title = title
        self.to = phoneNumbers
        self.data = data
        self.mimeType = mimeType
        self.timestamp = timestamp
    }
    
    init?(json: Any) {
        guard
            let json = json as? [String: Any],
            let id = json["device_id"] as? Int64,
            let to = json["to"] as? String,
            let data = json["data"] as? String,
            let mimeType = json["mime_type"] as? String,
            let title = json["title"] as? String,
            let timestamp = json["timestamp"] as? Int64
        else { return nil }
        
        self.id = id
        self.to = Account.encryptionUtils?.decrypt(data: to) ?? ""
        self.data = Account.encryptionUtils?.decrypt(data: data) ?? ""
        self.mimeType = Account.encryptionUtils?.decrypt(data: mimeType) ?? ""
        self.title = Account.encryptionUtils?.decrypt(data: title) ?? ""
        self.timestamp = timestamp
    }
}


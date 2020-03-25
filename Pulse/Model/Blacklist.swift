//
//  Blacklist.swift
//  Pulse
//
//  Created by Luke Klinker on 1/10/18.
//  Copyright © 2018 Luke Klinker. All rights reserved.
//

import Alamofire

struct Blacklist : ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    
    let id: Int64
    let phoneNumber: String?
    let phrase: String?
    
    var description: String {
        return "Blacklist: { phone_number: \(String(describing: phoneNumber)), phrase: \(String(describing: phrase)) }"
    }
    
    init(id: Int64, phoneNumber: String?, phrase: String?) {
        self.id = id
        self.phoneNumber = phoneNumber
        self.phrase = phrase
    }
    
    init?(json: Any) {
        guard
            let json = json as? [String: Any],
            let id = json["device_id"] as? Int64
        else { return nil }
        
        let phoneNumber = Blacklist.getOptionalString(representation: json, key: "phone_number")
        let phrase = Blacklist.getOptionalString(representation: json, key: "phrase")
        
        self.id = id
        self.phoneNumber = phoneNumber ?? ""
        self.phrase = phrase ?? ""
    }
    
    private static func getOptionalString(representation: [String: Any], key: String) -> String? {
        let value = representation[key]
        if !(value is NSNull) {
            return Account.encryptionUtils?.decrypt(data: (value as? String)!) ?? nil
        } else {
            return nil
        }
    }
}

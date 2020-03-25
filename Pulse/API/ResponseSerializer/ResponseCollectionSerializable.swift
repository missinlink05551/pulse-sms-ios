//
//  ResponseCollectionSerializable.swift
//  Pulse
//
//  Created by Luke Klinker on 1/1/18.
//  Copyright © 2018 Luke Klinker. All rights reserved.
//

import Alamofire

protocol ResponseCollectionSerializable {
    static func collection(json: Any) -> [Self]
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    static func collection(json: Any) -> [Self] {
        var collection: [Self] = []
        
        if let json = json as? [[String: Any]] {
            for itemJson in json {
                if let item = Self(json: itemJson) {
                    collection.append(item)
                }
            }
        }
        
        return collection
    }
}

//
//  DataRequest.swift
//  Pulse
//
//  Created by Luke Klinker on 1/1/18.
//  Copyright © 2018 Luke Klinker. All rights reserved.
//

import Alamofire

extension DataRequest {
    func responseObject<T: ResponseObjectSerializable>(
        completionHandler: @escaping (T) -> Void)
    {
        responseJSON { response in
            if let json = response.value, let item = T(json: json) {
                completionHandler(item)
            }
        }
    }
    
    @discardableResult
    func responseCollection<T: ResponseCollectionSerializable>(
        completionHandler: @escaping ([T]) -> Void) -> Self
    {
        responseJSON { response in
            if let json = response.value {
                completionHandler(T.collection(json: json))
            }
        }
    }
}

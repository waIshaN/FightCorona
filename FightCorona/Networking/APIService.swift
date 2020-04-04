//
//  APIService.swift
//  FightCorona
//
//  Created by Wai Shan on 2/4/20.
//  Copyright © 2020 Wai Shan. All rights reserved.
//

import Foundation

struct K {
    
    struct serverURL {
        static let baseURL = "https://corona.lmao.ninja"
    }
    
    struct path {
        static let all = "/all"
        static let countries = "/countries"
    }
    
    struct paramKey {
        
    }
    
}

struct HTTPHeaderField {
    static let authentication = "Authorization"
    static let contentType = "Content-Type"
    static let acceptType = "Accept"
    static let acceptEncoding = "Accept-Encoding"
}

struct ContentType {
    static let json = "application/json"
}

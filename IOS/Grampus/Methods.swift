//
//  Methods.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/30/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import Foundation

struct StatusCode: Decodable  {
    var statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "Status Code"
    }
}

enum Methods: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

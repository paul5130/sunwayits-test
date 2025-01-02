//
//  UserData.swift
//  sunwayits
//
//  Created by Paul Wen on 2025/1/2.
//

import Foundation

struct UserResponse: Decodable{
    let response: [UserData]
    
}

struct UserData: Decodable{
    let name: String
    let kokoid: String?
}

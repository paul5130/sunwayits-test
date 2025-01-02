//
//  Friend.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//

import Foundation

struct GetFriend: Decodable{
    let response: [Friend]
    
}

struct Friend: Decodable{
    let name: String
    let status: Int
    let isTop: String
    let fid: String
    let updateDate: String
}

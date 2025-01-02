//
//  FriendLoader.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//

import Foundation

typealias LoadFriendResult = (Result<[FriendItem],Error>)

protocol FriendLoader{
    func load(completion: @escaping(LoadFriendResult) -> Void)
}

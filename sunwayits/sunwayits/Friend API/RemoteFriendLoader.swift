//
//  RemoteFriendLoader.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//

import Foundation

class RemoteStockLoader{
    let url: URL
    let client: HTTPClient
    enum Error: Swift.Error{
        case connectivity
        case invalidData
    }
    init(url: URL,client: HTTPClient){
        self.url = url
        self.client = client
    }
    func load(completion: @escaping(Error) -> Void){
        client.get(from: url) {[weak self] result in
            guard self != nil else { return }
            switch result{
            case .success:
                completion(.invalidData)
            case .failure:
                completion(.connectivity)
            }
        }
    }
}

//
//  HttpClient.swift
//  sunwayits
//
//  Created by Paul Wen on 2024/12/31.
//

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse),Error>
public protocol HTTPClient{
    func get(from url: URL,completion: @escaping((HTTPClientResult) -> Void))
}

//
//  HomeViewModel.swift
//  sunwayits
//
//  Created by Paul Wen on 2025/1/2.
//

import Foundation

class HomeViewModel{
    private let apiService = APIService()
    func fetchFriends(from url: String,completion: @escaping(Result<[FriendItem],APIError>) -> Void){
        apiService.fetchData(from: url) { (result: Result<[FriendItem], APIError>) in
            switch result{
            case .success(let friends):
                completion(.success(friends))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

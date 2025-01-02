//
//  HomeViewModel.swift
//  sunwayits
//
//  Created by Paul Wen on 2025/1/2.
//

import Foundation

struct FriendsData{
    let invitingFriends: [Friend]
    let friends: [Friend]
    let isEmpty: Bool
    init(invitingFriends: [Friend], friends: [Friend]) {
        self.invitingFriends = invitingFriends
        self.friends = friends
        self.isEmpty = invitingFriends.isEmpty && friends.isEmpty
    }
}

class HomeViewModel{
    private let apiService = APIService()
    private let friendApiUrls: [String]
    private let userDataUrl = "https://dimanyen.github.io/man.json"
    private var allFriends = [Friend]()
    var filteredFriends = [Friend]()
    
    init(friendState: FriendState) {
        friendApiUrls = Self.getUrls(friendState)
    }
    func fetchFriends(completion: @escaping(Result<FriendsData,APIError>) -> Void){
        var results = [Friend]()
        let group = DispatchGroup()
        for url in friendApiUrls{
            group.enter()
            apiService.fetchData(from: url) { (result: Result<FriendResponse, APIError>) in
                print("url: \(url)")
                switch result {
                case .success(let response):
                    let friends = response.response
                    results += friends
                case .failure(let error):
                    completion(.failure(error))
                }
                group.leave()
            }
        }
        group.notify(queue: .main){
            var mergedDict = [String: Friend]()
            for friend in results {
                if let existing = mergedDict[friend.fid]{
                    if friend.updateDate > existing.updateDate{
                        mergedDict[friend.fid] = friend
                    }
                }else{
                    mergedDict[friend.fid] = friend
                }
            }
            let resultFriends = Array(mergedDict.values)
            let invitingFriends = resultFriends.filter{$0.status == 0}
            let isFriends = resultFriends.filter{$0.status != 0}
            self.allFriends = isFriends
            self.filteredFriends = isFriends
            let friendsData = FriendsData(invitingFriends: invitingFriends, friends: isFriends)
            completion(.success(friendsData))
        }
    }
    func fetchUserData(completion: @escaping(Result<UserData,APIError>) -> Void){
        apiService.fetchData(from: userDataUrl) { (result: Result<UserResponse,APIError>) in
            switch result {
            case .success(let response):
                guard let userData = response.response.first else {
                    completion(.failure(.invalidResponse))
                    return
                }
                completion(.success(userData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func filterFriends(_ keyword: String){
        if keyword.isEmpty{
            filteredFriends = allFriends
        }else{
            filteredFriends = allFriends.filter{ $0.name.contains(keyword)}
        }
    }
    
    private static func getUrls(_ friendState: FriendState) -> [String] {
        switch friendState {
        case .noFriends:
            return ["https://dimanyen.github.io/friend4.json"]
        case .friendWithInvites:
            return ["https://dimanyen.github.io/friend3.json"]
        case .friendWithoutInvites:
            return ["https://dimanyen.github.io/friend1.json","https://dimanyen.github.io/friend2.json"]
        }
    }
}

extension HomeViewModel{
    func fetchSingleApi<T: Decodable>(url: String, completion: @escaping (Result<T, APIError>) -> Void) {
        apiService.fetchData(from: url, completion: completion)
    }
    func fetchMultipleApis(urls: [String], completion: @escaping (Result<[Friend], APIError>) -> Void) {
        var results = [Friend]()
        let group = DispatchGroup()
        var fetchError: APIError?
        
        for url in urls {
            group.enter()
            fetchSingleApi(url: url) { (result: Result<FriendResponse, APIError>) in
                switch result {
                case .success(let response):
                    results.append(contentsOf: response.response)
                case .failure(let error):
                    fetchError = error
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if let error = fetchError {
                completion(.failure(error))
            } else {
                completion(.success(results))
            }
        }
    }
    static func mergeFriends(_ friends: [Friend]) -> [Friend] {
        var mergedDict = [String: Friend]()
        for friend in friends {
            if let existing = mergedDict[friend.fid] {
                if friend.updateDate > existing.updateDate {
                    mergedDict[friend.fid] = friend
                }
            } else {
                mergedDict[friend.fid] = friend
            }
        }
        return Array(mergedDict.values)
    }
}

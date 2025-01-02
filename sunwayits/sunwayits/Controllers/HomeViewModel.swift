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
}

class HomeViewModel{
    private let apiService = APIService()
    private let urls: [String]
    private let userDataUrl = "https://dimanyen.github.io/man.json"
    init(friendState: FriendState) {
        switch friendState {
        case .noFriends:
            urls = ["https://dimanyen.github.io/friend4.json"]
        case .friendWithInvites:
            urls = ["https://dimanyen.github.io/friend3.json"]
        case .friendWithoutInvites:
            urls = ["https://dimanyen.github.io/friend2.json","https://dimanyen.github.io/friend2.json"]
        }
    }
    func fetchFriends(completion: @escaping(Result<FriendsData,APIError>) -> Void){
//        let url = "https://dimanyen.github.io/friend1.json"
        apiService.fetchData(from: urls.first!) { (result: Result<GetFriend, APIError>) in
            switch result{
            case .success(let response):
                let friends = response.response
                var mergedDict = [String: Friend]()
                for friend in friends {
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
                let friendsData = FriendsData(invitingFriends: invitingFriends, friends: isFriends)
                completion(.success(friendsData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchUserData(completion: @escaping(Result<UserData,APIError>) -> Void){
        apiService.fetchData(from: userDataUrl) { (result: Result<GetUserData,APIError>) in
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
}

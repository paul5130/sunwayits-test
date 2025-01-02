//
//  APIService.swift
//  sunwayits
//
//  Created by Paul Wen on 2025/1/2.
//

import Foundation

enum APIError: Error{
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}

class APIService{
    func fetchData<T: Decodable>(from urlString: String,completion: @escaping(Result<T,APIError>) -> Void){
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                completion(.failure(.networkError(error)))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else{
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else { return }
            do{
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }catch{
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}

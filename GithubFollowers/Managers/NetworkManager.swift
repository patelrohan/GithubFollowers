//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Rohan on 9/1/23.
//

import UIKit

class NetworkManager{
    
    static let sharedNetworkManager     = NetworkManager()
    private let baseURL                 = "https://api.github.com/users/"
    let cache                           = NSCache<NSString, UIImage>()
    
    private init(){}
    
    
    func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], GHFError>) -> Void){
        
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let _ = error{
                completed(.failure(.invalidServerResponse))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidServerResponse))
                return
            }
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getUserInfo(for username: String, completed: @escaping(Result<User, GHFError>) -> Void){
        let endPoint = baseURL + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidServerResponse))
                return
            }
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}

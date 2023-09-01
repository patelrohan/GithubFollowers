//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Rohan on 9/1/23.
//

import Foundation

class NetworkManager{
    
    static let sharedNetworkManager     = NetworkManager()
    let baseURL                         = "https://api.github.com/users/"
    
    private init(){}
    
    
    func getFollowers(for username: String, page: Int, completed: @escaping([Follower]?, String?) -> Void){
        
        let endPoint = baseURL + "\(username)/followers?per_page=60&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(nil, "This username created invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                completed(nil, "Unable to complete your request. Please check your internet connection.")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, "Invalid response from the server. Please try again.")
                return
            }
            guard let data = data else{
                completed(nil, "Data received from the server was invalid. Please try again.")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            }catch{
                completed(nil, "Data received from the server was invalid. Please try again.")
            }
        }
        
        task.resume()
    }
}

//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Rohan on 8/17/23.
// 

import UIKit

class FollowersListVC: UIViewController {
    
    var userName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        NetworkManager.sharedNetworkManager.getFollowers(for: userName, page: 1) { result in
            switch result{
                
            case .success(let followers):
                print(followers)
                
            case .failure(let error):
                self.presentGHFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
//        NetworkManager.sharedNetworkManager.getFollowers(for: userName, page: 1) { (followers, errorMessage) in
//            guard let followers = followers else {
//                self.presentGHFAlertOnMainThread(title: "Something went wrong", message: errorMessage!.rawValue, buttonTitle: "Ok")
//                return
//            }
            
//            print("Count: \(followers.count)")
//            print(followers)
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

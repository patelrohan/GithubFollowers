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

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.sharedNetworkManager.getFollowers(for: userName, page: 1) { (followers, errorMessage) in
            guard let followers = followers else {
                self.presentGHFAlertOnMainThread(title: "Something went wrong", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            
            print("Count: \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

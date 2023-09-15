//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Rohan on 9/13/23.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBtn
        
        NetworkManager.sharedNetworkManager.getUserInfo(for: username) { [weak self] result in
            
            guard let self = self else { return }
        
            switch result{
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGHFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    

    @objc func dismissVC(){
        dismiss(animated: true)
    }

}

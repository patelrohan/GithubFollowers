//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Rohan on 9/13/23.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews   = [UIView]()
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureVC()
        layoutUI()
        getUserInfo()
    }
    
    private func configureVC(){
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBtn
    }
    
    private func getUserInfo(){
        NetworkManager.sharedNetworkManager.getUserInfo(for: username) { [weak self] result in
            
            guard let self = self else { return }
        
            switch result{
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GHFUserInfoHeaderVC(user: user), to: self.headerView)
                }
               
            case .failure(let error):
                self.presentGHFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func layoutUI(){
        itemViews = [headerView, itemViewOne, itemViewTwo]
        
        for itemView in itemViews{
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }

        itemViewOne.backgroundColor = .systemRed
        itemViewTwo.backgroundColor = .systemTeal
        headerView.backgroundColor = .systemPink
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant:  padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant:  padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
        ])
    }

    private func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }

}

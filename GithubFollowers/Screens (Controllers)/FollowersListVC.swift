//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Rohan on 8/17/23.
// 

import UIKit

class FollowersListVC: UIViewController {
    
    enum Section { case main }
    
    var userName: String = ""
    var followers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource <Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureCollectionView()
        configureDataSource()
        getFollowers()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout{
        let width                           = view.bounds.width
        let padding: CGFloat                = 12.0
        let minimumItemSpacing: CGFloat     = 10.0
        let totalAvailableWidth             = width - (2 * padding) - (2 * minimumItemSpacing)
        let itemWidth                       = totalAvailableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                 = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func getFollowers(){
        NetworkManager.sharedNetworkManager.getFollowers(for: userName, page: 1) { [weak self] result in
            
            guard let self = self else {return}
            
            switch result{
               
            case .success(let followers):
                self.followers = followers
                self.updateData()
                
            case .failure(let error):
                self.presentGHFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
        //Networkmanager before refactoring (without using Result)
        
       /* NetworkManager.sharedNetworkManager.getFollowers(for: userName, page: 1) { (followers, errorMessage) in
            guard let followers = followers else {
                self.presentGHFAlertOnMainThread(title: "Something went wrong", message: errorMessage!.rawValue, buttonTitle: "Ok")
                return
            }
            
            print("Count: \(followers.count)")
            print(followers)
        }*/
    }
    
    
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
       
    }
    
    

}

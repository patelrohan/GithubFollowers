//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Rohan on 8/17/23.
// 

import UIKit

class FollowersListVC: UIViewController, UISearchControllerDelegate {
    
    enum Section { case main }
    
    var userName: String                = ""
    var followers: [Follower]           = []
    var filteredFollowers: [Follower]   = []
    var page                            = 1
    var hasMoreFollowers                = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource <Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureCollectionView()
        configureDataSource()
        getFollowers(username: userName, page: page)
        configureSearchController()
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
        self.collectionView.delegate = self
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
    
    
    func configureSearchController(){
        let searchController                         = UISearchController()
        searchController.searchResultsUpdater        = self
        searchController.searchBar.delegate          = self
        searchController.searchBar.placeholder       = "Search for a username"
        navigationItem.searchController              = searchController
        navigationItem.hidesSearchBarWhenScrolling   = false
    }
    
    
    func getFollowers(username: String, page: Int){
        showLoadingView()
        NetworkManager.sharedNetworkManager.getFollowers(for: userName, page: self.page) { [weak self] result in
            
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result{
               
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty{
                    let message = "This user does not have any followers. Go follow them!"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                }
                self.updateData(with: self.followers)
                
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
    
    
    
    func updateData(with followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
       
    }
    
}

extension FollowersListVC: UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > (contentHeight - height) {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: userName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let follower            = dataSource.itemIdentifier(for: indexPath) //activeArray[indexPath.item]
        
        let destinationVC       = UserInfoVC()
        destinationVC.username  = follower?.login
        let navController       = UINavigationController(rootViewController: destinationVC)
    
        present(navController, animated: true)
    }
}


extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(with: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(with: self.followers)
    }
}

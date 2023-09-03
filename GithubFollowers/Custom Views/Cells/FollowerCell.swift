//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Rohan on 9/2/23.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    let avatarImgView = GFHAvatarImageView(frame: .zero)
    let usernameLabel = GHFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubview(avatarImgView)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8.0
        
        NSLayoutConstraint.activate([
            avatarImgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImgView.heightAnchor.constraint(equalTo: avatarImgView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImgView.bottomAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    func set(follower: Follower){
        usernameLabel.text = follower.login
    }
}

//
//  GHFItemInfoView.swift
//  GithubFollowers
//
//  Created by Rohan on 9/17/23.
//

import UIKit

enum ItemInfoType{
    case repos, gists, following, followers
}

class GHFItemInfoView: UIView {

    let iconImageView   = UIImageView()
    let titleLabel      = GHFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = GHFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode   = .scaleAspectFill
        iconImageView.tintColor     = .label
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leftAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int){
        switch itemInfoType {
        
        case .repos:
            iconImageView.image = UIImage(named: SFSymbols.repos)
            titleLabel.text = "Public Repos"
            
        case .gists:
            iconImageView.image = UIImage(named: SFSymbols.gist)
            titleLabel.text = "Public Gists"
        
        case .following:
            iconImageView.image = UIImage(named: SFSymbols.followers)
            titleLabel.text = "Followers"
        
        case .followers:
            iconImageView.image = UIImage(named: SFSymbols.following)
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
        
}

//
//  GFHAvatarImageView.swift
//  GithubFollowers
//
//  Created by Rohan on 9/2/23.
//

import UIKit

class GFHAvatarImageView: UIImageView {
    
    let placeholderImg = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImg!
       
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}

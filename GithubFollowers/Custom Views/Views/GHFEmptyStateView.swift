//
//  GHFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Rohan on 9/10/23.
//
import UIKit

class GHFEmptyStateView: UIView {

    let messageLabel    = GHFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImgView     = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String){
        super.init(frame: .zero)
        self.messageLabel.text = message
        configure()
    }
    
    private func configure(){
        addSubview(messageLabel)
        addSubview(logoImgView)
        
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
       
        
        logoImgView.image           = UIImage(named: "empty-state-logo")
        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
                        
            logoImgView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImgView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }

}

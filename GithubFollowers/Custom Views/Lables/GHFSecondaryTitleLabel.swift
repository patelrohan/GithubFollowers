//
//  GHFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Rohan on 9/15/23.
//

import UIKit

class GHFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super .init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(fontSize: CGFloat){
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configureLabel()
    }
        
    private func configureLabel(){
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}

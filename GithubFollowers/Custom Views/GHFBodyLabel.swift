//
//  GHFBodyLabel.swift
//  GithubFollowers
//
//  Created by Rohan on 8/30/23.
//

import UIKit

class GHFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }

    private func configure(){
        self.textColor              = .secondaryLabel
        font                        = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.75
        lineBreakMode               = .byWordWrapping
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}

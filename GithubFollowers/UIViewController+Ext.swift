//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Rohan on 8/31/23.
//

import UIKit

extension UIViewController{
    
    func presentGHFAlertOnMainThread(title: String, message: String, buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC = GHFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}

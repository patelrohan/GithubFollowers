//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Rohan on 8/31/23.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController{
    
    func presentGHFAlertOnMainThread(title: String, message: String, buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC = GHFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        self.view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25){ containerView.alpha = 0.75 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView){
        let emptyStateView = GHFEmptyStateView(message: message)
        emptyStateView.frame = self.view.bounds
        view.addSubview(emptyStateView)
        
    }
    
}

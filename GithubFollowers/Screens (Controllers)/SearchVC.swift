//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Rohan on 8/14/23.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GHFTextField()
    let getFollowersBtn = GHFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool{
        return !(usernameTextField.text!.isEmpty)
    }
    
    func dismissKeyboard(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowersListVC(){
        
        guard isUsernameEntered else  {
            presentGHFAlertOnMainThread(title: "Empty Username", message: "Please enter a username to search for   😀", buttonTitle: "Ok")
            return
        }
        
        let followersListVC         = FollowersListVC()
        followersListVC.userName    = usernameTextField.text ?? "apple"
        followersListVC.title       = usernameTextField.text ?? "apple"
        
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureUsernameTextField()
        configureGetFollowersBtn()
        dismissKeyboard()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    
    func configureUsernameTextField(){
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureGetFollowersBtn(){
        view.addSubview(getFollowersBtn)
        getFollowersBtn.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getFollowersBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            getFollowersBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowersBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowersBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
    
}


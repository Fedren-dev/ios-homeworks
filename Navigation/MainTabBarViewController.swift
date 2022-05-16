//
//  MainTabBarViewController.swift
//  Navigation
//
//  Created by Alexander Fedorov on 23.04.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let userFeedVC = FeedViewController()
    let profileVC = ProfileViewController()
    
    let loginVC = LogInViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()

    }
    
    private func setupControllers() {
        let userFeedNC = UINavigationController(rootViewController: userFeedVC)
        userFeedVC.tabBarItem.title = "Лента"
        userFeedVC.tabBarItem.image = UIImage(systemName: "newspaper")
        userFeedVC.navigationItem.title = "Feed"
        
        let profileNC = UINavigationController(rootViewController: loginVC)
        loginVC.tabBarItem.title = "Профиль"
        loginVC.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
        loginVC.navigationItem.title = "Profile"

        
        viewControllers = [userFeedNC, profileNC]
    }
    
    private func setupNavigationController() {
        let navBar = UINavigationBarAppearance()
        navBar.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = navBar
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBar
        view.backgroundColor = .white
    }
}

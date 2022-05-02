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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()

    }
    
    private func setupControllers() {
        let userFeedNC = UINavigationController(rootViewController: userFeedVC)
        userFeedVC.tabBarItem.title = "Feed"
        userFeedVC.tabBarItem.image = UIImage(systemName: "newspaper")
        userFeedVC.navigationItem.title = "Feed"
        
        let profileNC = UINavigationController(rootViewController: profileVC)
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
        profileVC.navigationItem.title = "Profile"

        
        viewControllers = [userFeedNC, profileNC]
    }
}

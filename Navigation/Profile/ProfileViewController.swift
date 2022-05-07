//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Alexander Fedorov on 03.05.2022.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()
    
    let newButton: UIButton = {
        let buttonNew = UIButton()
        buttonNew.setTitle("NewPost", for: .normal)
        buttonNew.backgroundColor = .systemBlue
        return buttonNew
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayuot()
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        
        let navigationBar = UINavigationBarAppearance()
        navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = navigationBar
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBar
        view.backgroundColor = .lightGray
    }
    
    private func setupAutoLayuot() {
        
        view.addSubview(profileHeaderView)
        view.addSubview(newButton)
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints.self = false
        newButton.translatesAutoresizingMaskIntoConstraints.self = false
        
        NSLayoutConstraint.activate([
            
            
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            
            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

//
//  PostViewController.swift
//  Navigation
//
//  Created by Alexander Fedorov on 30.04.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post?
    //var titlePost: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        //self.navigationItem.title = titlePost
    
        makeBarItem()
       setupController()
    }
    
    
    private func setupController() {
        if let post = post {
            
            self.title = post.title
        } else {
            
            self.title = "Default title"
        }
    }
    
    private func makeBarItem(){
        let barItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = barItem
    }
    @objc private func tapAction(){
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)

    }
}

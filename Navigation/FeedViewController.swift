//
//  FeedViewController.swift
//  Navigation
//
//  Created by Alexander Fedorov on 30.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Мой пост")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        postButton()
    }
    
    private func postButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.center = view.center
        button.setTitle("Post", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func tapAction() {
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.titlePost = post.title
    }
    

}

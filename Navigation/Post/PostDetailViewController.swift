//
//  PostDetailViewController.swift
//  Navigation
//
//  Created by Alexander Fedorov on 24.05.2022.
//

import UIKit

class PostDetailViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout ()
        
        view.backgroundColor = .systemGray6
        navigationItem.title = "Подробнее"
        navigationController?.navigationBar.isHidden = false
    }
    
    let scrollView: UIScrollView = {
        let viewScroll = UIScrollView()
        viewScroll.translatesAutoresizingMaskIntoConstraints = false
        return viewScroll
        
    } ()
    
    var viewContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var postImageView: UIImageView = {
        let imageView = UIImageView ()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var authourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    var descriptionLable: UILabel = {
        let descriptionLable = UILabel()
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLable.textColor = .systemGray
        descriptionLable.numberOfLines = 0
        return descriptionLable
    }()
    
    var likesLable: UILabel = {
        let lableLike = UILabel()
        lableLike.translatesAutoresizingMaskIntoConstraints = false
        lableLike.font = .systemFont(ofSize: 16, weight: .regular)
        lableLike.textColor = .black
        return lableLike
    }()
    
    var viewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewContent)
        
        
        [viewLabel, authourLabel,postImageView,likesLable, descriptionLable ].forEach {viewContent.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            //констрейн для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            //констрейн для viewContent
            viewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // важно что бы работало
            
            // Констрейнт для authourLabel
            authourLabel.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 16),
            authourLabel.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16),
            authourLabel.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16),
            
            // Констрейнт для postImageView
            postImageView.topAnchor.constraint(equalTo: authourLabel.bottomAnchor, constant: 16),
            postImageView.leadingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            
            // Констрейнт для descriptionLable
            descriptionLable.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLable.leadingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLable.trailingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // Констрейнт для likesLable
            likesLable.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 16),
            likesLable.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16),
            likesLable.trailingAnchor.constraint(equalTo: viewContent.centerXAnchor),
            likesLable.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -16),
            
            // Констрейнт для viewLabel
            viewLabel.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 16),
            viewLabel.leadingAnchor.constraint(equalTo: viewContent.centerXAnchor),
            viewLabel.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16),
            viewLabel.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -16)
        ])
    }
    
}

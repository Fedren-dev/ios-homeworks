//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Alexander Fedorov on 11.05.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    
    weak var  tapPostImageDelegate: TapPostImageDelegate?
    
    
    private var modelPostFull = PostModel(author: "", description: "", image: UIImage(named:"cat1")!, likes: 1, view: 1)
    
    private var mainView: UIView = {
        let viewWhite = UIView()
        viewWhite.translatesAutoresizingMaskIntoConstraints = false
        return viewWhite
    }()
    
    private var postImageView: UIImageView = {
        let imageView = UIImageView ()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private var authourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private var descriptionLable: UILabel = {
        let descriptionLable = UILabel()
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLable.textColor = .systemGray
        descriptionLable.numberOfLines = 0
        return descriptionLable
    }()
    
    private var likesLable: UILabel = {
        let lableLike = UILabel()
        lableLike.translatesAutoresizingMaskIntoConstraints = false
        lableLike.font = .systemFont(ofSize: 16, weight: .regular)
        lableLike.textColor = .black
        lableLike.isUserInteractionEnabled = true
        return lableLike
    }()
    
    private var viewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    // переообределяю инициализатор
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // прописываю Gestures
    private func setupGestures() {
        
        let tapLikeGesture = UITapGestureRecognizer(target: self, action: #selector(likeAction))
        likesLable.addGestureRecognizer(tapLikeGesture)
        
        let tapPostImageViewGesture = UITapGestureRecognizer(target: self, action: #selector(postImageViewAction))
        postImageView.addGestureRecognizer(tapPostImageViewGesture)
        
    }
    
    @objc private func likeAction() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            
            self.modelPostFull.likes += 1
            self.likesLable.text = "Likes: \(self.modelPostFull.likes)"
        }
    }
    
    @objc private func postImageViewAction() {
        
        // delegate?.buttonTap
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            
            self.modelPostFull.view += 1
            self.viewLabel.text = "Views: \(self.modelPostFull.view)"
            self.tapPostImageDelegate?.postImagePressed(author: self.modelPostFull.author, description: self.modelPostFull.description ?? "", image: self.modelPostFull.image)
            
        }
    }
    
    // подписываю PostModel под элементы таблицы
    func setupCell(_ post: PostModel) {
        modelPostFull = post
        authourLabel.text = post.author
        postImageView.image = post.image
        descriptionLable.text = post.description
        likesLable.text = "Likes: \(post.likes)"
        viewLabel.text = "Views: \(post.view)"
    }
    
    private func layout() {
        [mainView, postImageView,descriptionLable, authourLabel, likesLable, viewLabel].forEach {contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            // Констрейнт для ячейки
            mainView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            
            // Констрейнт для authourLabel
            authourLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            authourLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            authourLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            
            // Констрейнт для postView
            postImageView.topAnchor.constraint(equalTo: authourLabel.bottomAnchor, constant: 16),
            postImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            
            // Констрейнт для descriptionLable
            descriptionLable.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLable.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            descriptionLable.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            
            // Констрейнт для likesLable
            likesLable.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 16),
            likesLable.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            likesLable.trailingAnchor.constraint(equalTo: mainView.centerXAnchor),
            likesLable.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            
            // Констрейнт для viewLabel
            viewLabel.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 16),
            viewLabel.leadingAnchor.constraint(equalTo: mainView.centerXAnchor),
            viewLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            viewLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16)
        ])
    }
}




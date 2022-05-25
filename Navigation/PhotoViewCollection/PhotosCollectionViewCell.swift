//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Alexander Fedorov on 16.05.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    weak var buttonAllPhotoCellDelegate: PhotoCellDelegate?
    
    private let galleryImages: UIImageView = {
        let galleryImage = UIImageView()
        galleryImage .translatesAutoresizingMaskIntoConstraints = false
        galleryImage .contentMode = .scaleAspectFill
        galleryImage .clipsToBounds = true
        galleryImage.layer.cornerRadius = 6
        return galleryImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageLayout()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoAction))
        galleryImages.addGestureRecognizer(tapGesture)
        galleryImages.isUserInteractionEnabled = true
    }
    
    @objc private func photoAction() {
        buttonAllPhotoCellDelegate?.tapAction(photo: galleryImages.image!)
    }
    
    // добавляю метод показа фото
    func setupImageModel(_ image: ImageModel) {
        galleryImages.image = UIImage(named: image.image)
    }
    
    private func imageLayout() {
        contentView.addSubview(galleryImages)
        
        // констрейны  imageView на TableView для CollectionView
        NSLayoutConstraint.activate([
            galleryImages.topAnchor.constraint(equalTo: contentView.topAnchor),
            galleryImages.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            galleryImages.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            galleryImages.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

protocol PhotoCellDelegate: AnyObject {
    func  tapAction(photo: UIImage)
    func  cancelAnimationButton()
}

//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Alexander Fedorov on 16.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    
    // вызоваю метод добавления картинок
    var imageModel = ImageModel.addImage()
    
    private lazy var photoCollection: UICollectionView = {
        let layoutForCollection = UICollectionViewFlowLayout()
        let collectionGallery = UICollectionView(frame: .zero, collectionViewLayout: layoutForCollection )
        collectionGallery.translatesAutoresizingMaskIntoConstraints = false
        collectionGallery.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.indentifire)
        collectionGallery.dataSource = self
        collectionGallery.delegate = self
        return collectionGallery
    }()
    
    private lazy var buttonCancel: UIButton = {
        let button = UIButton()
        button.layer.opacity = 0
        button.setImage(UIImage(named: "closer"), for: .normal)
        button.addTarget(self, action: #selector(cancelAnimationButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let blackView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .black
        view.alpha = 0.8
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.opacity = 0
        return view
    }()
    
    var fullScreenImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "photo1"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 0
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // добавляю  title в фото
        self.navigationItem.title = "Фото Галерея"
        setupLayout()
    }
    
    private func setupLayout() {
        
        [photoCollection, blackView, fullScreenImageView, buttonCancel].forEach({view.addSubview($0)})
        
        //добавляю констрейнты для коллекции
        NSLayoutConstraint.activate([
            photoCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //констрейнты для полноэкранного фото
            fullScreenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullScreenImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fullScreenImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            fullScreenImageView.heightAnchor.constraint(equalTo: fullScreenImageView.widthAnchor, multiplier: 1),
            
            //констрейнты для кнопки выход
            buttonCancel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            buttonCancel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            buttonCancel.widthAnchor.constraint(equalToConstant: 40),
            buttonCancel.heightAnchor.constraint(equalTo: buttonCancel.widthAnchor, multiplier: 1)
        ])
    }
}


// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.indentifire, for: indexPath) as! PhotosCollectionViewCell
        cell.setupImageModel(imageModel[indexPath.item])
        cell.buttonAllPhotoCellDelegate = self
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    // Метод для установки высоты меджу фотографиями
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
    
    // Метод для устновки расстояний со всех сторон
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
}


// MARK: - TapPostImageDelegate

extension PhotosViewController: PhotoCellDelegate {
    
    func tapAction(photo: UIImage) {
        self.fullScreenImageView.image = photo
        self.fullScreenImageView.isUserInteractionEnabled = true
        self.navigationController?.isNavigationBarHidden = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            
            self.blackView.layer.opacity = 0.85
            self.fullScreenImageView.layer.opacity = 1
            self.view.layoutIfNeeded()
            
        } completion: { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0.0) {
                self.buttonCancel.layer.opacity = 1
            }
        }
    }
    
    @objc func cancelAnimationButton() {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            self.buttonCancel.layer.opacity = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0.0) {
                self.blackView.layer.opacity = 0.0
                self.fullScreenImageView.layer.opacity = 0
                self.navigationController?.isNavigationBarHidden = false
                self.view.layoutIfNeeded()
            }
        }
    }
}

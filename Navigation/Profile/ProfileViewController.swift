//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Alexander Fedorov on 03.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var postModel = PostModel.makePostModel()
    private lazy var imageModel = ImageModel.addImage()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .zero
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.indentifire)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.indentifire)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout ()
        // перекрасил плашку навигайшенбара в серый -согласно макету
        self.view.backgroundColor = .systemGray6
        hideKeyboardTapperAround()
        // добавил обратные переход в профиль
        navigationItem.title = "Профиль"
        navigationController?.navigationBar.isHidden = false
    }

    private func layout () {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return postModel.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.indentifire, for: indexPath) as! PostTableViewCell
           // Делегат для детального просмотра поста!!!
            cell.tapPostImageDelegate = self
            cell.setupCell(postModel[indexPath.row - 1])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.indentifire, for: indexPath) as! PhotosTableViewCell
            cell.setupLabel("")
            //Кнопка перехода в Галерею
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
    }
}
// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension   // автоматические размеры - условия элементы должны быть четко привязанны и к верху и к низу
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.backgroundColor = .systemGray6
        return section == 0 ? profileHeaderView: nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 200:0
    }
    
    //  исчезновения выделения ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)

    }
}

extension ProfileViewController: PhotosTableViewCellDelegate {
    func buttonTap() {
        
        let photosViewController = PhotosViewController()
        navigationController?.pushViewController(photosViewController, animated: true)
    }
}


// MARK: - TapPostImageDelegate

extension ProfileViewController: TapPostImageDelegate {
    func postImagePressed(author: String, description: String, image: UIImage) {
        let newView = PostDetailViewController()
        newView.authourLabel.text = author
        newView.postImageView.image = image
        newView.descriptionLable.text = description
        navigationController?.pushViewController(newView, animated: true)
    }
}

// MARK: - Расширение скрывает клавиатуру

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// Расширение скрывает клавиатуру по тапу на любую часть экрана
extension ProfileViewController: UITextViewDelegate {
    
    func hideKeyboardTapperAround() {
        
        let press: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        press.cancelsTouchesInView = false
        view.addGestureRecognizer(press)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

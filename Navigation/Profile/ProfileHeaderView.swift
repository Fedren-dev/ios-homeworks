//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Alexander Fedorov on 03.05.2022.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var avatarImageView: UIImageView = {
        
        let imageView = UIImageView(image: UIImage(named: "cat"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 55
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    private lazy var setStatusButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.tintColor = .systemRed
        button.setTitle("Set status", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.textColor = UIColor.systemRed
        
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.addTarget(self, action: #selector(buttonStatus), for: .touchUpInside)
        return button
    } ()
    
    private var fullNameLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lazy cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var statusView: UITextView = {
        
        let textView = UITextView ()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Waiting for something"
        textView.backgroundColor = .clear
        textView.textColor = .gray
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textView
    }()
    
    lazy var textField: UITextField = {
        let fieldText = UITextField(frame: CGRect(x: 130, y: text.frame.maxY + 5 , width: 240, height: 40))
      fieldText.text = ""
      fieldText.backgroundColor = .white
      fieldText.layer.cornerRadius = 12
      fieldText.layer.borderWidth = 1
      fieldText.layer.borderColor = UIColor.black.cgColor
      fieldText.font = UIFont.systemFont(ofSize: 15, weight: .regular)
      fieldText.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
      return fieldText
  }()
    
    
    private var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = ""
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()
    
    @objc private func buttonStatus() {
        statusView.text = statusText
        print(statusView.text ?? "")
    }
    
    @objc private func statusTextChanged() {
        statusText = statusTextField.text ?? ""
        }
    
    private func setupLayout() {
        [avatarImageView, setStatusButton, fullNameLabel, statusView, statusTextField].forEach {self.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 110),
            avatarImageView.heightAnchor.constraint(equalToConstant: 110),
            
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16 ),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            
            
            statusView.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -6),
            statusView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusView.heightAnchor.constraint(equalToConstant: 30),
            
            
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -16),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}

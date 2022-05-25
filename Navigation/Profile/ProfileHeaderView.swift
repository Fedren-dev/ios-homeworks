//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Alexander Fedorov on 03.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayuot()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // добавляю аватарку
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "cat"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 55
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true    // Обрезаю по баундс
        imageView.contentMode = .scaleAspectFill  //без растяжки
        imageView.isUserInteractionEnabled = true
        return imageView
    } ()
    
    private lazy var additionalAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    // добавляю кнопуку
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.textColor = UIColor.systemRed
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        //действия кнопки
        button.addTarget(self, action: #selector(buttonStatus), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelAnimationButton: UIButton = {
        let button = UIButton()
        button.layer.opacity = 0
        button.setImage(UIImage(named: "closer"), for: .normal)
        button.addTarget(self, action: #selector(pressCancelAnimationButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .black
        view.alpha = 0.8
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.opacity = 0
        // view.isHidden = true
        return view
    }()
    
    // добавляю текстовое поле для имени
    private lazy var fullNameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lazy cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // добавляю поле для статуса
    private lazy var statusView: UITextView = {
        let textView = UITextView ()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Waiting for something"
        textView.backgroundColor = .clear
        textView.textColor = .gray
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textView
    }()
    
    // добавляю поле для ввода статуса
    // убал свойство lazy что бы обновлялось поле placeholder = "Set something" после ввода статуса
    private var statusTextField: UITextField = {
        let fieldText = UITextField()
        fieldText.translatesAutoresizingMaskIntoConstraints = false
        fieldText.placeholder = "Set something"
        fieldText.backgroundColor = .white
        fieldText.layer.cornerRadius = 12
        fieldText.layer.borderWidth = 1
        fieldText.layer.borderColor = UIColor.black.cgColor
        fieldText.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        fieldText.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: fieldText.frame.height))
        fieldText.leftViewMode = .always
        fieldText.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return fieldText
    }()
    
    @objc private func buttonStatus() {
        if statusTextField.text == "" {
            statusTextField.attributedPlaceholder = NSAttributedString(
                string: "Не может быть пустым",
                attributes: [NSAttributedString.Key.foregroundColor:UIColor.red]
            )
        }
        guard statusTextField.text != "" else { return }
        statusView.text = statusText ?? ""
        
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    
    
    // MARK: - Animation  добавляю функционал анимации
       private func setupGestures (){
           let tapGesture = UITapGestureRecognizer (target: self, action: #selector(tapAction))
           avatarImageView.addGestureRecognizer(tapGesture)
       }
    
       @objc private func tapAction(){
           
           UIView.animate(withDuration: 0.5,
                          delay: 0.0,
                          usingSpringWithDamping: 1.0,
                          initialSpringVelocity: 0.0,
                          options: .curveEaseInOut) {

               
               self.avatarImageView.layer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
               self.avatarImageView.layer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
               self.blackView.layer.opacity = 0.8
               self.avatarImageView.layer.cornerRadius = 0
               self.layoutIfNeeded()

           } completion: { _ in
               UIView.animate(withDuration: 0.3,
                              delay: 0.0) {
               self.cancelAnimationButton.layer.opacity = 1
               }
           }

       }
       
       @objc private func pressCancelAnimationButton() {
           UIView.animate(withDuration: 0.3,
                          delay: 0.0,
                          usingSpringWithDamping: 1.0,
                          initialSpringVelocity: 0.0,
                          options: .curveEaseInOut) {
               self.cancelAnimationButton.layer.opacity = 0
           } completion: { _ in
               UIView.animate(withDuration: 0.5,
                              delay: 0.0) {
                   self.blackView.layer.opacity = 0.0
                   self.avatarImageView.layer.position = self.additionalAvatar.layer.position
                   self.avatarImageView.layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
                   self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.width / 2
                   self.layoutIfNeeded()
               }
           }
       }
    
    
    // добавляю функцию авторесайзинга
    private func setupLayuot (){
        [fullNameLable, statusTextField, setStatusButton, statusView, additionalAvatar, blackView, avatarImageView, cancelAnimationButton ].forEach {self.addSubview($0)}  // добавляю массив из сабвью
        
        // активирую лайот общим массивом
        NSLayoutConstraint.activate([
            
            // настройка отображение avatarImageView
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            additionalAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            additionalAvatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            additionalAvatar.heightAnchor.constraint(equalToConstant: 100),
            additionalAvatar.widthAnchor.constraint(equalTo: additionalAvatar.heightAnchor, multiplier: 1),
            
            // настройка отображение cancelAnimationButton
            cancelAnimationButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cancelAnimationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            cancelAnimationButton.widthAnchor.constraint(equalToConstant: 40),
            cancelAnimationButton.heightAnchor.constraint(equalTo: cancelAnimationButton.widthAnchor, multiplier: 1),
            
        
            //настройка отображение fullNameLable
            fullNameLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            
            //настройка отображение statusView
            statusView.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -6),
            statusView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusView.heightAnchor.constraint(equalToConstant: 30),
            
            //настройка отображение setStatusButton
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16 ),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            // настройка отображение statusTextField
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -16),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

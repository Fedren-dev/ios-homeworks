//
//  LoginViewController.swift
//  Navigation
//
//  Created by Alexander Fedorov on 07.05.2022.
//

import Foundation
import UIKit

class LogInViewController: UIViewController {
    
    private lazy var login = "admin"
    private lazy var password = "admin"
    
    private let notificationCenter = NotificationCenter.default
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true  // скрывает надпись профиль сверху
        setupLayuot()
        hideKeyboardTapperAround()
        
        logTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    //добавляю отображение Логотипа ВК
    private lazy var logoImageView: UIImageView = {
        let logoIV = UIImageView(image: UIImage(named: "logo"))
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        logoIV.layer.borderColor = UIColor.lightGray.cgColor
        return logoIV
    }()
    
    // создаю стейк логин и пароль
    private lazy var stackViewLoginPassword: UIStackView = {
        let loginPasswordSV = UIStackView()
        loginPasswordSV.translatesAutoresizingMaskIntoConstraints = false
        loginPasswordSV.axis = .vertical
        loginPasswordSV.distribution = .fillEqually
        loginPasswordSV.backgroundColor = .systemGray6
        loginPasswordSV.layer.cornerRadius = 10
        loginPasswordSV.layer.borderColor = UIColor.lightGray.cgColor
        loginPasswordSV.layer.borderWidth = 0.5
        loginPasswordSV.layer.masksToBounds = true    // обрезает по границам
        loginPasswordSV.spacing = 0.1
        return loginPasswordSV
    }()
    
    // создаю поле ввода для почты или телефона
    private lazy var logTextField: UITextField = {
        let logTF = UITextField()
        logTF.translatesAutoresizingMaskIntoConstraints = false
        logTF.placeholder = "Email or phone"
        logTF.layer.borderWidth = 0.5
        logTF.layer.borderColor = UIColor.lightGray.cgColor
        logTF.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        logTF.textColor = .black
        logTF.autocapitalizationType = .none
        logTF.tintColor = .lightGray
        // отодвинул текст от угла
        logTF.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: logTF.frame.height))
        logTF.leftViewMode = .always
        return logTF
    }()
    
    // создаю поле ввода пароля
    private lazy var passwordTextField: UITextField = {
        let passwordTF = UITextField()
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.placeholder = "Password"
        passwordTF.layer.borderColor = UIColor.lightGray.cgColor
        passwordTF.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordTF.textColor = .black
        passwordTF.autocapitalizationType = .none
        passwordTF.isSecureTextEntry = true
        passwordTF.tintColor = .lightGray
        // отодвинул текст от угла
        passwordTF.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: passwordTF.frame.height))
        passwordTF.leftViewMode = .always
        return passwordTF
        
    }()
    
    // создаю кнопку Log In
    private lazy var loginButton: UIButton = {
        let buttonLogin = UIButton()
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.backgroundColor = UIColor(hexString: "#4885CC")  // нужно заменить - согласно макета !!
        buttonLogin.tintColor = .white
        buttonLogin.setTitle("Log In", for: .normal)
        buttonLogin.layer.cornerRadius = 10
        buttonLogin.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return buttonLogin
    }()
    
    // всплывающее предупреждение о длинне пароля
    private lazy var alertLabel: UILabel = {
        let labelAlert = UILabel()
        labelAlert.translatesAutoresizingMaskIntoConstraints = false
        labelAlert.text = "Внимание! Пароль слишком короткий"
        labelAlert.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        labelAlert.textColor = .red
        labelAlert.textAlignment = .center
        labelAlert.isHidden = true

        
        return labelAlert
    }()
    
    //действие кнопки - переход на экран ProfileViewController
    @objc private func tapAction() {
        // проверка логина и пароля на пустоту
        
        
        if logTextField.text == login && passwordTextField.text == password {
            
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
            }
        
        else {
        
        if logTextField.text == "" || passwordTextField.text == "" {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.1
            animation.repeatCount = 2
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: stackViewLoginPassword.center.x - 5, y: stackViewLoginPassword.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: stackViewLoginPassword.center.x + 5, y: stackViewLoginPassword.center.y))
            stackViewLoginPassword.layer.add(animation, forKey: "position")
            
            logTextField.attributedPlaceholder = NSAttributedString (string: logTextField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            passwordTextField.attributedPlaceholder = NSAttributedString (string: passwordTextField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
            
        } else {
            stackViewLoginPassword.layer.removeAnimation(forKey: "position")
            
        }
        // проверка пароля на длинну
        if passwordTextField.text!.count < 4 && passwordTextField.text != "" {
            
            alertLabel.isHidden = false
            
            _ = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(alertTimer), userInfo: nil, repeats: false)
            return
            }
        else {
            alertLabel.isHidden = true

        }
            
            if logTextField.text != login && logTextField.text != ""  || passwordTextField.text != password && passwordTextField.text != "" {
            let alertController = UIAlertController()
            alertController.title = "Неправильно введен логин или пароль"
            alertController.message = "Пожалуйста, проверьте правильность введеных данных и попробуйте еще раз"
            
            let okAction = UIAlertAction(title: "Выйти", style: .default)
            alertController.addAction(okAction)
            
            present(alertController,animated: true)
                        
            
        }
        
        }
    }
    
    // таймер на появление alertLabel
    @objc private func alertTimer() {
        alertLabel.isHidden = true
    }
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    } ()
    
    private lazy var contentView: UIView = {
        let contenView = UIView()
        contenView.translatesAutoresizingMaskIntoConstraints = false
        contenView.backgroundColor = .white
        return contenView
    }()
    
    // добавляю наблюдетеля за клавиатурой
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil )
    }
    
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func  keyboardHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    // удаляю наблюдетеля за клавиатурой
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // добавляю отображение и лайауты
    private func setupLayuot() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginButton)
        contentView.addSubview(stackViewLoginPassword)
        // добавил лабел предупреждение на контент вью
        contentView.addSubview(alertLabel)
        
        // добавляю отображение на стейк
        [logTextField, passwordTextField] .forEach {stackViewLoginPassword.addArrangedSubview($0)}
        
        NSLayoutConstraint.activate([
            
            // автолэйот для стека логин и пароль
            stackViewLoginPassword.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackViewLoginPassword.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackViewLoginPassword.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackViewLoginPassword.heightAnchor.constraint(equalToConstant: 100),
            
           //автолэйот для предупреждения длинны пароля
            alertLabel.topAnchor.constraint(equalTo: stackViewLoginPassword.bottomAnchor, constant: 1),
            alertLabel.leadingAnchor.constraint(equalTo: stackViewLoginPassword.leadingAnchor),
            alertLabel.trailingAnchor.constraint(equalTo: stackViewLoginPassword.trailingAnchor),
            alertLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -1),

        
            // автолэйот для Логотипа
            logoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            //автолэйот для кнопки логин
            loginButton.topAnchor.constraint(equalTo: stackViewLoginPassword.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // автолайаут для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // автолайаут для contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
    }
}

//убираем клавиатуру
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func hideKeyboardTapperAround() {
        
        let press: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        press.cancelsTouchesInView = false
        view.addGestureRecognizer(press)
    }
    @objc func dismissKeyboard(){
    
        view.endEditing(true)
    }
}

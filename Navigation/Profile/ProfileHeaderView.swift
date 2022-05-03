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
        addSubview(image)
        addSubview(setupButton)
        addSubview(nameLable)
        addSubview(text)
        addSubview(textField)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private var image: UIImageView = {
        
        let imageView = UIImageView(image: UIImage(named: "cat"))
        imageView.layer.frame = CGRect(x: 16, y: 16, width: 110, height: 110)
        imageView.layer.cornerRadius = 55
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    } ()
    
    private lazy var setupButton: UIButton = {
        
        let button = UIButton(frame: CGRect(x: 16, y: image.frame.maxY + 16, width: UIScreen.main.bounds.width - 32, height: 50))
        button.backgroundColor = .systemBlue
        button.tintColor = .systemRed
        button.setTitle("Set status", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.textColor = UIColor.systemRed
        
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return button
    } ()
    
    private var nameLable: UILabel = {
        
        let label = UILabel(frame: CGRect(x: 180, y: 27, width: 120, height: 30))
        label.text = "Lazy cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black

            return label
        
    }()
    
    private lazy var text: UITextView = {
        
        let textView = UITextView (frame: CGRect(x: 180, y: nameLable.frame.maxY + 3 , width: 179, height: 28))
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
    
    
    
    @objc private func buttonPressed() {
      
        text.text = statusText
        print(text.text ?? "")
    }
    
    @objc private func statusTextChanged() {
        
        statusText = textField.text ?? ""
        }
    
}

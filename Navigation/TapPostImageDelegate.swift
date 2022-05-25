//
//  TapPostImageDelegate.swift
//  Navigation
//
//  Created by Alexander Fedorov on 24.05.2022.
//

import UIKit

protocol TapPostImageDelegate: AnyObject {
    func postImagePressed(author: String, description: String, image: UIImage)
}

//
//  ImageModel.swift
//  Navigation
//
//  Created by Alexander Fedorov on 16.05.2022.
//

import UIKit

// создаю структуру для картинок
struct ImageModel {
    var image: String
    
    static func addImage() -> [ImageModel] {
        var image = [ImageModel]()
        
        image.append(ImageModel(image: "ph1"))
        image.append(ImageModel(image: "ph2"))
        image.append(ImageModel(image: "ph3"))
        image.append(ImageModel(image: "ph4"))
        image.append(ImageModel(image: "ph5"))
        image.append(ImageModel(image: "ph7"))
        image.append(ImageModel(image: "ph9"))
        image.append(ImageModel(image: "ph11"))
        image.append(ImageModel(image: "ph20"))
        image.append(ImageModel(image: "ph1"))
        image.append(ImageModel(image: "ph2"))
        image.append(ImageModel(image: "ph3"))
        image.append(ImageModel(image: "ph4"))
        image.append(ImageModel(image: "ph5"))
        image.append(ImageModel(image: "ph7"))
        image.append(ImageModel(image: "ph9"))
        image.append(ImageModel(image: "ph11"))
        image.append(ImageModel(image: "ph20"))
        return image
    }
}

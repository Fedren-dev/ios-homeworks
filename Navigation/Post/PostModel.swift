//
//  PostModel.swift
//  Navigation
//
//  Created by Alexander Fedorov on 11.05.2022.
//

import UIKit

struct PostModel {
    var author: String
    var description: String?
    var image: String
    var likes: Int
    var view: Int
    
    static func makePostModel() -> [PostModel] {
        var post = [PostModel]()
        post.append(PostModel(author: "Автор 1", description: "Какое-то очень длинное или короткое описание, которого может быть или не быть 1", image: ("cat1"), likes: 333, view: 338))
        post.append(PostModel(author: "Автор 2", description: "Какое-то очень длинное или короткое описание, которого может быть или не быть 2", image: ("cat2"), likes: 100, view: 110))
        post.append(PostModel(author: "Автор 3", description: "Какое-то очень длинное или короткое описание, которого может быть или не быть 3", image: ("cat3"), likes: 290, view: 300))
        post.append(PostModel(author: "Автор 4", description: "Какое-то очень длинное или короткое описание, которого может быть или не быть 4", image: ("cat4"), likes: 121, view: 132))
        return post
    }
}

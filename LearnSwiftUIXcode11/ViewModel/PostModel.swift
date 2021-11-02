//
//  PostModel.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/11/2.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation

class PostModel: Identifiable{
    let id = UUID()
    let post: PostResponse
    
    init(article: PostResponse){
        self.post = article
    }
    
    var title: String{
        return post.title ?? ""
    }
    var description: String{
        return post.body ?? ""
    }
}

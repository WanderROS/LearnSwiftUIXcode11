//
//  PostViewModel.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/11/2.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation

class PostViewModel: ObservableObject{
    
    init(){
        print("postview model 初始化！！！！！")
        getPost(id: 1)
    }
    
    @Published var article = PostModel(article: PostResponse(userId: 1, id: 2, title: "hell", body: "test"))
    
    func getPost(id:Int){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")else{
            return
        }
        NetworkManager.loadData(url: url, completion: {
            articles in
            if let articles  = articles{
                self.article = PostModel(article:articles)
            }
        })
    }
}

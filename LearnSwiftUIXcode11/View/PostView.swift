//
//  PostView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/11/2.
//  Copyright © 2021 xcode11. All rights reserved.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var model = PostViewModel()
    @State private var num: Int = 1
    var body: some View {
        List{
            VStack(alignment: .leading) {
                Text(model.article.title)
                Text(model.article.description)
                    .foregroundColor(.secondary)
            }
            Button("加一"){
                self.num += 1
                self.model.getPost(id: self.num)
            }
            Button("减一"){
                self.num -= 1
                if self.num <= 1{
                    self.num = 1
                }
                self.model.getPost(id: self.num)
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}

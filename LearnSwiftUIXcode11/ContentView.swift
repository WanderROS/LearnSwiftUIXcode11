//
//  ContentView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/10/18.
//  Copyright © 2021 xcode11. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        VStack{
            TextField("请输入用户名", text: $username)
                .padding([.leading],25)
                .padding([.bottom],15)
            TextField("请输入密码", text: $password)
                .padding([.leading],25)
                .padding([.bottom],30)
            Button(action: {
                let publisher = Just(5).map { value -> Int in
                    return value
                }.sink { value in
                    print("最终结果接收到的值为 \(value)")
                }
            }) {
                Text("登录")
                    .foregroundColor(.white)
            }
            .frame(width:120,height: 40)
            .background(Color.blue)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/10/29.
//  Copyright © 2021 xcode11. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView : View {
    @State private var selected = 3
    var body: some View {
            TabView(selection: $selected) {
                VStack {
                    Text("hello")
                    Text("Nice")
                }
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("First")
                }.tag(0)
                Text("Another Tab")
                    .tabItem {
                        Image(systemName: "2.square.fill")
                        Text("Second")
                    }.tag(1)
                Text("The Last Tab")
                    .tabItem {
                        Image(systemName: "3.square.fill")
                        Text("Third")
                    }.tag(2)
                Text("The Last Tab")
                    .tabItem {
                        if selected == 3 {
                            Image(systemName: "square.and.arrow.up")
                        } else{
                              Image(systemName: "4.square.fill")
                        }
                        Text("Forth")
                }.tag(3)
            }
            .font(.headline)
            .accentColor(.black)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  dev
//
//  Created by Wander on 2021/11/3.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation

import SwiftUI

struct ContentView: View {
    @State private var num: Int = 1
    var body: some View {
        List{
            Button("加一"){
                self.num += 1
            }
            Button("减一"){
                self.num -= 1
                if self.num <= 1{
                    self.num = 1
                }            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/10/29.
//  Copyright © 2021 xcode11. All rights reserved.
//

import SwiftUI
import Combine

import EFQRCode

struct ContentView : View {
    @State private var selected = 3
    @State private var image : CGImage?
    @State private var dataUrl = Bundle.main.url(forResource: "QRCodeGIF6", withExtension: "gif")
    var body: some View {
            TabView(selection: $selected) {
                VStack {
                    Text("hello")
                    Text("Nice")
                    Button("Generate"){
                        if let image = EFQRCode.generate(
                            for: "https://github.com/EFPrefix/EFQRCode"
                        ) {
                            print("Create QRCode image success \(image)")
                            self.image = image
                        } else {
                            print("Create QRCode image failed!")
                        }
                    }.padding()
                    Button("Reconginze"){
                        if let testImage = self.image {
                            let codes = EFQRCode.recognize(testImage)
                            if !codes.isEmpty {
                                print("There are \(codes.count) codes")
                                for (index, code) in codes.enumerated() {
                                    print("The content of QR Code \(index) is \(code).")
                                }
                            } else {
                                print("There is no QR Codes in testImage.")
                            }
                        }
                    }
                    if image != nil {
                        Image(image!, scale: 2, label: Text("测试"))
                    }
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

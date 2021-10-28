//
//  ContentView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/10/18.
//  Copyright © 2021 xcode11. All rights reserved.
//

import SwiftUI
import Combine

struct DetailView : View {
    @State private var data : Int = 0
    var body: some View {
        VStack {
            Text("\(data)")
            Button("++"){
                data = data + 1
            }
        }
    }
    init(data:Int) {
        self.data = data
    }
    
}



struct ContentView : View {
    
    @State var data: String
    @State var cancellables = Set<AnyCancellable>()
    var body: some View {
        VStack{
            Text("Hello")
            let a = 100
            DetailView(data: a)
            TextField("test", text: $data)
            Button(action: {
                NetworkService.shared.getWebData().sink(receiveCompletion: {_ in
                }) { (value) in
                    self.data = value
                }.store(in: &self.cancellables)
            }) {
                Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(data: "Hello")
    }
}

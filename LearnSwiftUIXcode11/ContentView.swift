//
//  ContentView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/10/18.
//  Copyright © 2021 xcode11. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = "hello"
    var body: some View {
        NavigationView{
            NavigationLink(destination: MyViewController().navigationBarTitle("MyViewController",displayMode: .inline)){
                Text("Hello")
            }
        }
    }
}

struct MyViewController: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.gray
        return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

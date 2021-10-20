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
        VStack{
            List(0...5,id: \.self){ id  in
                TableViewCell(text: self.$text)
            }
        }
    }
}

struct TableViewCell: UIViewRepresentable{
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<TableViewCell>) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = text
        cell.selectionStyle = .gray
        return cell
    }
    
    func updateUIView(_ uiView: UITableViewCell, context: Context) {
        uiView.textLabel?.text = text
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

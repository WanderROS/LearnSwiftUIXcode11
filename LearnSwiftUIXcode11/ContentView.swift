//
//  ContentView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/10/18.
//  Copyright © 2021 xcode11. All rights reserved.
//

import SwiftUI
import Combine

struct AdaptView : View{
    @Environment(\.verticalSizeClass) var verticalSizeClass
        
    let products = [
      ("Mac", "desktopcomputer"),
      ("iPhone", "desktopcomputer"),
      ("Airpods", "desktopcomputer")
    ]

    var body: some View {
            VStack(spacing: 0){
                ForEach(products, id:\.0) { v in
                    HStack{
                        Image(systemName: v.1)
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(7)
                        
                        Text("\(v.0)")
                        Spacer()
                      
                        }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(Color.red)
                        }
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.yellow)
                        .frame(width: 200, height: 200)

                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.red)
                        .frame(width: 80, height: 80)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .frame(width: 40, height: 40)
                }

            }
        }
}


struct ContentView : View {
    var body: some View {
        AdaptView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
      ("iPhone", "iphone"),
      ("Airpods", "airpodspro")
    ]
    func product(_ item: (String, String)) -> some View {
        HStack{
            Image(systemName: item.1)
                .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(7)
            
            Text("\(item.0)")
            Spacer()
          
        }
        .padding(EdgeInsets(top: 1, leading: 15, bottom: 0, trailing: 15))
          
    }
    var body: some View {
        if verticalSizeClass == .regular{
            VStack{
                ForEach(products, id:\.0) { v in
                          product(v)
                        }

            }
        }else{
            HStack{
                ForEach(products, id:\.0) { v in
                          product(v)
                        }

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

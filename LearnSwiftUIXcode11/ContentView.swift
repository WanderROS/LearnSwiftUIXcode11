//
//  ContentView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/10/18.
//  Copyright © 2021 xcode11. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading){
            List{
                Text("Hello").font(.headline).foregroundColor(.blue).italic()
                Text("World").bold().foregroundColor(.green)
                Text("\(UUID())").bold().foregroundColor(.orange)
                #if DEBUG
                Button(action: self.ButtonClick) {
                    Text("Debug")
                        .bold().italic()
                }.background(RoundedRectangle(cornerRadius: 7).foregroundColor(.green))
                #else
                Button(action: self.ButtonClick) {
                    Text("Release")
                        .bold().italic()
                }.background(RoundedRectangle(cornerRadius: 7).foregroundColor(.green))
                #endif
            }
        }
    }
    func ButtonClick()->Void{
        print("Button Clicked!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

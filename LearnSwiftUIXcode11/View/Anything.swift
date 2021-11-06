//
//  Anything.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/11/6.
//  Copyright © 2021 xcode11. All rights reserved.
//

import SwiftUI

struct Anything<T: UIView>: UIViewRepresentable {
    typealias UIViewType = T
    
    var makeView: () -> T
    var update: (T,Context) -> Void
    
    init(_ makeView: @escaping @autoclosure ()->T, update: @escaping (T)->Void) {
        self.makeView = makeView
        self.update = {view, _ in update(view)}
    }
    
    func makeUIView(context: Context) -> T {
        makeView()
    }
    
    func updateUIView(_ uiView: T, context: Context) {
        update(uiView,context)
    }
    
}

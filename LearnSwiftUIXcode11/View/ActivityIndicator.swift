//
//  ActivityIndicator.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/11/6.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable{
    var boolStart: Bool
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let uiView = UIActivityIndicatorView()
        uiView.style = .large
        return uiView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if self.boolStart {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

struct ActivityIndicator_Preview: PreviewProvider{
    static var previews: some View{
        ActivityIndicator(boolStart: true)
    }
}

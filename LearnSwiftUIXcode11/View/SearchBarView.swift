//
//  SearchBarView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/11/6.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct SearchBarView: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
    
}

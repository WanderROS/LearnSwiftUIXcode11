//
//  SearchBarCoordinator.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/11/6.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class SearchBarCoordinator: NSObject,UISearchBarDelegate {
    @Binding var text: String
    init(text: Binding<String>){
        _text = text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        text = searchText
    }
}

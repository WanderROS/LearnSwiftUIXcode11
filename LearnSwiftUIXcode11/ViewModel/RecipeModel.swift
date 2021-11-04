//
//  RecipeModel.swift
//  LearnSwiftUIXcode11
//
//  Created by Wander on 2021/11/3.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation

struct RecipeModel: Identifiable, Codable {
    
    var id = UUID()
    var name = ""
    var origin = ""
    var countryCode = ""
    var favourite = false
    var ingredients = [String]()
    var recipe = ""
}

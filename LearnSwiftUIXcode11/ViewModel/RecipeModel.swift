//
//  RecipeModel.swift
//  LearnSwiftUIXcode11
//
//  Created by Wander on 2021/11/3.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation
import UIKit

struct RecipeModel: Identifiable, Codable {
    
    var id = UUID()
    var name = ""
    var origin = ""
    var countryCode = ""
    var favourite = false
    var ingredients = [String]()
    var recipe = ""
    var imageData: Data?
    var image: UIImage {
        if let dataImage = UIImage(data: imageData ?? Data()) {
            return dataImage
        } else if let countryImage = UIImage(named: countryCode) {
            return countryImage
        }
        return UIImage()
    }
}

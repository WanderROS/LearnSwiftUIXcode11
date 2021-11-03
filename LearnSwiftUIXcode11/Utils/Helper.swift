//
//  Helper.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/11/3.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation
import UIKit

struct Helper{
    
    static func mockRecipes() -> [RecipeModel] {
        var recipes = [RecipeModel]()
        recipes.append(RecipeModel(name: "Italian Pizza Chicken", origin: "Italian", countryCode: "IT"))
        recipes.append(RecipeModel(name: "Greek Pasta Bake", origin: "Greek", countryCode: "GR"))
        recipes.append(RecipeModel(name: "Hearty Parsnip Soup", origin: "British", countryCode: "GB"))
        recipes.append(RecipeModel(name: "Honey & Soy Salmon", origin: "Chinese", countryCode: "CN"))
        return recipes
    }
    
    static func getFavorites() -> [RecipeModel] {
        if let data = UserDefaults.standard.data(forKey: "favorites"){
            let array = try! JSONDecoder().decode([RecipeModel].self, from: data)
            return array
        }
        return [RecipeModel]()
    }
    
    static func isFavorite(name: String) -> Bool {
        return getFavorites().contains(where: {($0.name == name)})
    }
    
    static func addRemoveFavorite(recipe: RecipeModel){
        var favorites = getFavorites()
        if !isFavorite(name: recipe.name){
            favorites.append(recipe)
        } else {
            favorites.removeAll(where:{ $0.name == recipe.name})
        }
        
        let data = try! JSONEncoder().encode(favorites)
        
        UserDefaults.standard.set(data,forKey: "favorites")
    }
}

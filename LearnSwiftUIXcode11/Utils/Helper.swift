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
    
    
    static func saveRecipes(recipes:[RecipeModel]){
        let data = try! JSONEncoder().encode(recipes)
        UserDefaults.standard.set(data,forKey: "recipes")
    }
    
    static func getRecipes(filter: String = "") -> [RecipeModel] {
        if let data = UserDefaults.standard.data(forKey: "recipes"){
            var arr = try! JSONDecoder().decode([RecipeModel].self, from: data)
            
            if filter != "" {
                arr = arr.filter {
                    $0.origin == filter
                }
            }
            return arr
        }
        return [RecipeModel]()
    }
    
    private static func getMockIngredients() -> [String] {
        return ["1 x Ingredient One",
                "2tbp Ingredient Two",
                "500g Ingredient Three",
                "2 x Ingredient Four"]
    }
    
    private static func getMockRecipe() -> String {
        return "Bacon ipsum dolor amet ad frankfurter pork aute nostrud leberkas jowl tenderloin dolore beef ribs. Ex tempor shankle, venison in ut cow deserunt. Do swine andouille, minim quis excepteur non shank eiusmod id buffalo. Duis shankle chuck picanha cow id minim esse. Qui burgdoggen capicola, venison culpa labore pastrami est minim bacon enim.\n\nExcepteur lorem turducken aute, qui ad hamburger chicken buffalo chislic brisket cupidatat pariatur. Jowl fugiat picanha pork belly quis. Ad shankle chuck est tri-tip ribeye sunt. Venison turkey tempor, occaecat beef biltong ut pork. Frankfurter sunt ad buffalo short loin cupidatat ipsum strip steak short ribs. Tri-tip porchetta fatback deserunt aute ut. Laborum nostrud aliquip pancetta deserunt, esse laboris pastrami."
    }
    
    static func mockRecipes() -> [RecipeModel] {
        var recipes = [RecipeModel]()
        recipes.append(RecipeModel(name: "Italian Pizza Chicken", origin: "Italian", countryCode: "IT",ingredients: getMockIngredients(), recipe: getMockRecipe()))
        recipes.append(RecipeModel(name: "Greek Pasta Bake", origin: "Greek", countryCode: "GR",ingredients: getMockIngredients(), recipe: getMockRecipe()))
        recipes.append(RecipeModel(name: "Hearty Parsnip Soup", origin: "British", countryCode: "GB",ingredients: getMockIngredients(), recipe: getMockRecipe()))
        recipes.append(RecipeModel(name: "Honey & Soy Salmon", origin: "Chinese", countryCode: "CN",ingredients: getMockIngredients(), recipe: getMockRecipe()))
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
    
    static func getCountries() -> [String] {
        return ["Italy", "Greece", "UK", "China", "France", "USA", "Mexico", "Spain"]
    }
    
    static func getCountryCode(country: String) -> String {
        switch country {
        case "Italy":
            return "IT"
        case "Greece":
            return "GR"
        case "UK":
            return "GB"
        case "China":
            return "CN"
        case "Mexico":
            return "MX"
        case "France":
            return "FR"
        case "USA":
            return "US"
        case "Spain":
            return "ES"
        default:
            return ""
        }
    }
    
    
}
